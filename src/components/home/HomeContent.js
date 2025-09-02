import React from 'react';
import { 
  TrendingUp, 
  Briefcase, 
  DollarSign, 
  GraduationCap, 
  MapPin,
  Clock,
  Star,
  ArrowRight,
  Users,
  Target,
  Award,
  Calendar
} from 'lucide-react';
import { opportunities } from '../../data/opportunities';
import { getRecentNews } from '../../data/news';

const HomeContent = ({ bookmarkedItems, toggleBookmark }) => {
  // Get recent news (latest 4)
  const recentNews = getRecentNews(4);

  // Sample events data
  const upcomingEvents = [
    {
      id: 1,
      title: "Rwanda Tech Summit 2025",
      date: "2025-09-15",
      location: "Kigali Convention Centre",
      type: "Conference",
      attendees: 500,
      category: "Technology"
    },
    {
      id: 2,
      title: "Diaspora Investment Forum",
      date: "2025-09-22",
      location: "Serena Hotel, Kigali",
      type: "Networking",
      attendees: 200,
      category: "Investment"
    },
    {
      id: 3,
      title: "Women in Business Meetup",
      date: "2025-09-28",
      location: "Impact Hub Kigali",
      type: "Meetup",
      attendees: 150,
      category: "Business"
    },
    {
      id: 4,
      title: "AgriTech Innovation Workshop",
      date: "2025-10-05",
      location: "University of Rwanda",
      type: "Workshop",
      attendees: 100,
      category: "Agriculture"
    }
  ];

  // Calculate stats
  const stats = {
    totalJobs: opportunities.filter(opp => opp.type === 'job').length,
    totalInvestments: opportunities.filter(opp => opp.type === 'investment').length,
    totalScholarships: opportunities.filter(opp => opp.type === 'scholarship').length,
    totalTenders: opportunities.filter(opp => opp.type === 'tender').length,
  };

  const getOpportunityIcon = (type) => {
    switch (type) {
      case 'job': return <Briefcase className="w-4 h-4" />;
      case 'investment': return <DollarSign className="w-4 h-4" />;
      case 'scholarship': return <GraduationCap className="w-4 h-4" />;
      case 'tender': return <Target className="w-4 h-4" />;
      default: return <Star className="w-4 h-4" />;
    }
  };

  const formatValue = (opportunity) => {
    switch (opportunity.type) {
      case 'job':
        return `$${opportunity.salary?.toLocaleString()}/year`;
      case 'investment':
        return `$${opportunity.amount?.toLocaleString()}`;
      case 'scholarship':
        return opportunity.value;
      case 'tender':
        return `$${opportunity.value?.toLocaleString()}`;
      default:
        return '';
    }
  };

  return (
    <div className="pb-4">
      {/* Welcome Section */}
      <div className="bg-black text-white p-6 m-4 rounded-lg border border-gray-300">
        <h1 className="text-2xl font-bold mb-2">Welcome to Rwanda Connect</h1>
        <p className="text-gray-300 mb-4">
          Discover opportunities across jobs, investments, scholarships, and tenders
        </p>
        <div className="flex items-center text-gray-300">
          <Users className="w-4 h-4 mr-2" />
          <span className="text-sm">Join thousands of Rwandans building their future</span>
        </div>
      </div>

      {/* Quick Stats */}
      <div className="px-4 mb-6">
        <h2 className="text-lg font-semibold mb-3 text-gray-800">Opportunities Available</h2>
        <div className="grid grid-cols-2 gap-3">
          <div className="bg-white p-4 rounded-lg border border-black">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-black font-semibold text-lg">{stats.totalJobs}</p>
                <p className="text-gray-700 text-sm">Jobs</p>
              </div>
              <Briefcase className="w-6 h-6 text-black" />
            </div>
          </div>
          
          <div className="bg-white p-4 rounded-lg border border-black">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-black font-semibold text-lg">{stats.totalInvestments}</p>
                <p className="text-gray-700 text-sm">Investments</p>
              </div>
              <DollarSign className="w-6 h-6 text-black" />
            </div>
          </div>
          
          <div className="bg-white p-4 rounded-lg border border-black">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-black font-semibold text-lg">{stats.totalScholarships}</p>
                <p className="text-gray-700 text-sm">Scholarships</p>
              </div>
              <GraduationCap className="w-6 h-6 text-black" />
            </div>
          </div>
          
          <div className="bg-white p-4 rounded-lg border border-black">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-black font-semibold text-lg">{stats.totalTenders}</p>
                <p className="text-gray-700 text-sm">Tenders</p>
              </div>
              <Target className="w-6 h-6 text-black" />
            </div>
          </div>
        </div>
      </div>

      {/* Recent News */}
      <div className="px-4 mb-6">
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-lg font-semibold text-gray-800">Recent News</h2>
          <button className="text-black text-sm flex items-center hover:text-gray-600">
            View All <ArrowRight className="w-4 h-4 ml-1" />
          </button>
        </div>
        
        <div className="space-y-3">
          {recentNews.map((article) => (
            <div key={article.id} className="bg-white p-4 rounded-lg border border-black shadow-sm">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-2">
                    <span className="text-xs bg-black text-white px-2 py-1 rounded-full">
                      {article.category}
                    </span>
                    <span className="text-xs text-gray-500 ml-2">
                      {article.source}
                    </span>
                  </div>
                  
                  <h3 className="font-medium text-gray-900 mb-2 line-clamp-2">
                    {article.title}
                  </h3>
                  
                  <p className="text-sm text-gray-600 mb-2 line-clamp-2">
                    {article.excerpt}
                  </p>
                  
                  <div className="flex items-center text-sm text-gray-500">
                    <Clock className="w-3 h-3 mr-1" />
                    <span className="mr-3">{article.readTime}</span>
                    <span>By {article.author}</span>
                  </div>
                </div>
                
                <button className="p-2 text-gray-400 hover:text-black transition-colors">
                  <Star className="w-4 h-4" />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Upcoming Events */}
      <div className="px-4 mb-6">
        <div className="flex items-center justify-between mb-3">
          <h2 className="text-lg font-semibold text-gray-800">Upcoming Events</h2>
          <button className="text-black text-sm flex items-center hover:text-gray-600">
            View All <ArrowRight className="w-4 h-4 ml-1" />
          </button>
        </div>
        
        <div className="grid grid-cols-1 gap-3">
          {upcomingEvents.map((event) => (
            <div key={event.id} className="bg-white p-4 rounded-lg border border-black shadow-sm">
              <div className="flex items-start justify-between">
                <div className="flex-1">
                  <div className="flex items-center mb-2">
                    <span className="text-xs bg-black text-white px-2 py-1 rounded-full">
                      {event.type}
                    </span>
                    <span className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded-full ml-2">
                      {event.category}
                    </span>
                  </div>
                  
                  <h3 className="font-medium text-gray-900 mb-2">
                    {event.title}
                  </h3>
                  
                  <div className="flex items-center text-sm text-gray-600 mb-2">
                    <Calendar className="w-3 h-3 mr-1" />
                    <span className="mr-3">{new Date(event.date).toLocaleDateString()}</span>
                    <MapPin className="w-3 h-3 mr-1" />
                    <span>{event.location}</span>
                  </div>
                  
                  <div className="flex items-center text-sm text-gray-500">
                    <Users className="w-3 h-3 mr-1" />
                    <span>{event.attendees} expected attendees</span>
                  </div>
                </div>
                
                <button className="bg-black text-white px-3 py-1 rounded text-sm hover:bg-gray-800 transition-colors">
                  Join
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Featured Content */}
      <div className="px-4 mb-6">
        <h2 className="text-lg font-semibold mb-3 text-gray-800">Featured Resources</h2>
        <div className="space-y-3">
          <div className="bg-black text-white p-4 rounded-lg border border-gray-300">
            <h3 className="font-semibold mb-1">Career Development Guide</h3>
            <p className="text-gray-300 text-sm mb-3">
              Essential tips for advancing your career in Rwanda's growing economy
            </p>
            <button className="text-white text-sm flex items-center hover:text-gray-300">
              Read More <ArrowRight className="w-4 h-4 ml-1" />
            </button>
          </div>
          
          <div className="bg-white text-black p-4 rounded-lg border border-black">
            <h3 className="font-semibold mb-1">Investment Opportunities 2025</h3>
            <p className="text-gray-700 text-sm mb-3">
              Discover high-potential sectors for investment in Rwanda
            </p>
            <button className="text-black text-sm flex items-center hover:text-gray-600">
              Explore <ArrowRight className="w-4 h-4 ml-1" />
            </button>
          </div>
        </div>
      </div>

      {/* Navigation Shortcuts */}
      <div className="px-4">
        <h2 className="text-lg font-semibold mb-3 text-gray-800">Quick Actions</h2>
        <div className="grid grid-cols-2 gap-3">
          <button className="bg-white p-4 rounded-lg border border-black text-left hover:bg-gray-100">
            <TrendingUp className="w-6 h-6 text-black mb-2" />
            <h3 className="font-medium text-gray-900 mb-1">Market Trends</h3>
            <p className="text-xs text-gray-600">View latest market insights</p>
          </button>
          
          <button className="bg-black text-white p-4 rounded-lg border border-black text-left hover:bg-gray-800">
            <Users className="w-6 h-6 text-white mb-2" />
            <h3 className="font-medium text-white mb-1">Community</h3>
            <p className="text-xs text-gray-300">Connect with professionals</p>
          </button>
        </div>
      </div>
    </div>
  );
};

export default HomeContent;