import React, { useState, useMemo } from 'react';
import { 
  Briefcase, 
  DollarSign, 
  GraduationCap, 
  Target,
  MapPin,
  Clock,
  Star,
  Award,
  Filter,
  Search,
  ArrowUpDown,
  Calendar,
  Building,
  TrendingUp,
  Eye
} from 'lucide-react';
import { opportunities } from '../../data/opportunities';

const OpportunitiesContent = ({ filters, bookmarkedItems, toggleBookmark }) => {
  const [activeCategory, setActiveCategory] = useState('all');
  
  const categories = [
    { id: 'all', label: 'All', count: opportunities.length },
    { id: 'job', label: 'Jobs', count: opportunities.filter(o => o.type === 'job').length },
    { id: 'investment', label: 'Investments', count: opportunities.filter(o => o.type === 'investment').length },
    { id: 'scholarship', label: 'Scholarships', count: opportunities.filter(o => o.type === 'scholarship').length },
    { id: 'tender', label: 'Tenders', count: opportunities.filter(o => o.type === 'tender').length }
  ];

  const getOpportunityIcon = (type) => {
    switch (type) {
      case 'job': return <Briefcase className="w-4 h-4" />;
      case 'investment': return <DollarSign className="w-4 h-4" />;
      case 'scholarship': return <GraduationCap className="w-4 h-4" />;
      case 'tender': return <Target className="w-4 h-4" />;
      default: return <Star className="w-4 h-4" />;
    }
  };

  const getTypeColor = (type) => {
    switch (type) {
      case 'job': return 'bg-green-100 text-green-700 border-green-200';
      case 'investment': return 'bg-blue-100 text-blue-700 border-blue-200';
      case 'scholarship': return 'bg-purple-100 text-purple-700 border-purple-200';
      case 'tender': return 'bg-orange-100 text-orange-700 border-orange-200';
      default: return 'bg-gray-100 text-gray-700 border-gray-200';
    }
  };

  const formatValue = (opportunity) => {
    switch (opportunity.type) {
      case 'job':
        return `$${opportunity.salary?.toLocaleString()}/year`;
      case 'investment':
        return `$${opportunity.amount?.toLocaleString()} • ${opportunity.returns}`;
      case 'scholarship':
        return `${opportunity.value} • ${opportunity.field}`;
      case 'tender':
        return `$${opportunity.value?.toLocaleString()} • ${opportunity.sector}`;
      default:
        return '';
    }
  };

  const getDaysUntilDeadline = (deadline) => {
    const today = new Date();
    const deadlineDate = new Date(deadline);
    const diffTime = deadlineDate - today;
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
    return diffDays;
  };

  const getUrgencyColor = (daysLeft) => {
    if (daysLeft <= 7) return 'text-red-600 bg-red-50';
    if (daysLeft <= 30) return 'text-orange-600 bg-orange-50';
    return 'text-green-600 bg-green-50';
  };

  // Filter and sort opportunities
  const filteredOpportunities = useMemo(() => {
    let filtered = [...opportunities];

    // Filter by category
    if (activeCategory !== 'all') {
      filtered = filtered.filter(opp => opp.type === activeCategory);
    }

    // Filter by search query
    if (filters?.searchQuery) {
      const query = filters.searchQuery.toLowerCase();
      filtered = filtered.filter(opp => 
        opp.title.toLowerCase().includes(query) ||
        opp.location.toLowerCase().includes(query) ||
        opp.company?.toLowerCase().includes(query) ||
        opp.industry?.toLowerCase().includes(query)
      );
    }

    // Apply filters
    if (filters?.activeFilters) {
      const { categories, locations, industries, salaryRange, deadlines } = filters.activeFilters;
      
      if (categories.length > 0) {
        filtered = filtered.filter(opp => categories.includes(opp.type));
      }
      
      if (locations.length > 0) {
        filtered = filtered.filter(opp => 
          locations.some(loc => opp.location.toLowerCase().includes(loc.toLowerCase()))
        );
      }
      
      if (industries.length > 0) {
        filtered = filtered.filter(opp => industries.includes(opp.industry));
      }
      
      if (salaryRange && (salaryRange[0] > 0 || salaryRange[1] < 200000)) {
        filtered = filtered.filter(opp => {
          const value = opp.salary || opp.amount || opp.value;
          if (typeof value === 'number') {
            return value >= salaryRange[0] && value <= salaryRange[1];
          }
          return true;
        });
      }
    }

    // Sort opportunities
    if (filters?.sortBy) {
      switch (filters.sortBy) {
        case 'recent':
          filtered.sort((a, b) => new Date(b.datePosted) - new Date(a.datePosted));
          break;
        case 'deadline':
          filtered.sort((a, b) => new Date(a.deadline) - new Date(b.deadline));
          break;
        case 'salary':
          filtered.sort((a, b) => (b.salary || b.amount || 0) - (a.salary || a.amount || 0));
          break;
        case 'title':
          filtered.sort((a, b) => a.title.localeCompare(b.title));
          break;
        default:
          break;
      }
    }

    return filtered;
  }, [activeCategory, filters]);

  return (
    <div className="pb-4">
      {/* Header */}
      <div className="sticky top-0 bg-white z-10 pb-4 border-b border-black">
        <div className="px-4 pt-4">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h1 className="text-xl font-bold text-black">Opportunities</h1>
              <p className="text-sm text-gray-600">{filteredOpportunities.length} opportunities found</p>
            </div>
            <div className="flex items-center space-x-2">
              <button 
                onClick={() => filters?.setShowFilters(true)}
                className="p-2 bg-white rounded-lg border border-black hover:bg-gray-100"
              >
                <Filter className="w-4 h-4 text-black" />
                {filters?.getActiveFilterCount() > 0 && (
                  <span className="absolute -top-1 -right-1 bg-black text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">
                    {filters.getActiveFilterCount()}
                  </span>
                )}
              </button>
              <button className="p-2 bg-white rounded-lg border border-black hover:bg-gray-100">
                <ArrowUpDown className="w-4 h-4 text-black" />
              </button>
            </div>
          </div>

          {/* Category Tabs */}
          <div className="flex space-x-1 bg-white p-1 rounded-lg border border-black overflow-x-auto">
            {categories.map((category) => (
              <button
                key={category.id}
                onClick={() => setActiveCategory(category.id)}
                className={`px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap transition-colors ${
                  activeCategory === category.id
                    ? 'bg-black text-white'
                    : 'text-gray-600 hover:text-black hover:bg-gray-100'
                }`}
              >
                {category.label} ({category.count})
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Opportunities List */}
      <div className="px-4 space-y-3">
        {filteredOpportunities.length === 0 ? (
          <div className="text-center py-12">
            <Search className="w-12 h-12 text-gray-300 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-gray-900 mb-2">No opportunities found</h3>
            <p className="text-gray-600 mb-4">Try adjusting your search or filters</p>
            <button 
              onClick={filters?.resetFilters}
              className="text-black hover:text-gray-600 font-medium"
            >
              Clear all filters
            </button>
          </div>
        ) : (
          filteredOpportunities.map((opportunity) => {
            const daysLeft = getDaysUntilDeadline(opportunity.deadline);
            const isBookmarked = bookmarkedItems.has(`${opportunity.type}-${opportunity.id}`);
            
            return (
              <div key={opportunity.id} className="bg-white p-4 rounded-lg border border-black shadow-sm hover:shadow-md transition-shadow">
                <div className="flex items-start justify-between mb-3">
                  <div className="flex-1">
                    {/* Header with type and verification */}
                    <div className="flex items-center mb-2">
                      <div className={`flex items-center px-2 py-1 rounded-full text-xs font-medium ${getTypeColor(opportunity.type)}`}>
                        <span className="mr-1">{getOpportunityIcon(opportunity.type)}</span>
                        {opportunity.type.charAt(0).toUpperCase() + opportunity.type.slice(1)}
                      </div>
                      {opportunity.verified && (
                        <div className="flex items-center ml-2 px-2 py-1 bg-green-50 text-green-700 rounded-full text-xs">
                          <Award className="w-3 h-3 mr-1" />
                          Verified
                        </div>
                      )}
                      <div className={`ml-2 px-2 py-1 rounded-full text-xs font-medium ${getUrgencyColor(daysLeft)}`}>
                        {daysLeft > 0 ? `${daysLeft} days left` : 'Expired'}
                      </div>
                    </div>

                    {/* Title */}
                    <h3 className="font-semibold text-gray-900 mb-2 line-clamp-2">
                      {opportunity.title}
                    </h3>

                    {/* Company/Organization */}
                    {opportunity.company && (
                      <div className="flex items-center text-sm text-gray-600 mb-2">
                        <Building className="w-3 h-3 mr-1" />
                        {opportunity.company}
                      </div>
                    )}

                    {/* Location and Value */}
                    <div className="flex items-center justify-between mb-3">
                      <div className="flex items-center text-sm text-gray-600">
                        <MapPin className="w-3 h-3 mr-1" />
                        {opportunity.location}
                      </div>
                      <div className="text-sm font-semibold text-green-600">
                        {formatValue(opportunity)}
                      </div>
                    </div>

                    {/* Requirements */}
                    <p className="text-sm text-gray-600 mb-3 line-clamp-2">
                      <span className="font-medium">Requirements:</span> {opportunity.requirements}
                    </p>

                    {/* Footer with deadline and actions */}
                    <div className="flex items-center justify-between">
                      <div className="flex items-center text-xs text-gray-500">
                        <Calendar className="w-3 h-3 mr-1" />
                        Deadline: {new Date(opportunity.deadline).toLocaleDateString()}
                        <span className="mx-2">•</span>
                        <Clock className="w-3 h-3 mr-1" />
                        Posted: {new Date(opportunity.datePosted).toLocaleDateString()}
                      </div>
                      
                      <div className="flex items-center space-x-2">
                        <button className="p-1 text-gray-400 hover:text-blue-600 transition-colors">
                          <Eye className="w-4 h-4" />
                        </button>
                        <button
                          onClick={() => toggleBookmark(opportunity.id, opportunity.type)}
                          className={`p-1 transition-colors ${
                            isBookmarked
                              ? 'text-red-500 hover:text-red-600'
                              : 'text-gray-400 hover:text-red-500'
                          }`}
                        >
                          <Star className="w-4 h-4" fill={isBookmarked ? 'currentColor' : 'none'} />
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            );
          })
        )}
      </div>

      {/* Load More Button */}
      {filteredOpportunities.length > 0 && (
        <div className="px-4 mt-6">
          <button className="w-full py-3 bg-white border border-gray-200 rounded-lg text-gray-600 hover:bg-gray-50 transition-colors">
            Load More Opportunities
          </button>
        </div>
      )}
    </div>
  );
};

export default OpportunitiesContent;