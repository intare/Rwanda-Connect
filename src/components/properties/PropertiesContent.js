import React, { useState } from 'react';
import {
  Search,
  Filter,
  MapPin,
  Bed,
  Bath,
  Car,
  Square,
  Eye,
  Heart,
  Star,
  DollarSign,
  Building,
  Home,
  X
} from 'lucide-react';
import {
  dummyProperties,
  propertyTypes,
  propertyCategories,
  propertyStatuses,
  rwandaDistricts,
  formatPrice,
  getPropertyStats
} from '../../data/properties';
import PropertyDetails from './PropertyDetails';

const PropertiesContent = () => {
  const [properties, setProperties] = useState(dummyProperties);
  const [selectedProperty, setSelectedProperty] = useState(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState({
    type: 'all',
    category: 'all',
    status: 'all',
    district: 'all',
    priceRange: [0, 1000000],
    bedrooms: 'all'
  });

  const stats = getPropertyStats();

  // Filter properties based on search and filters
  const filteredProperties = properties.filter(property => {
    // Search filter
    const matchesSearch = searchQuery === '' || 
      property.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      property.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
      property.location.neighborhood.toLowerCase().includes(searchQuery.toLowerCase()) ||
      property.location.district.toLowerCase().includes(searchQuery.toLowerCase());

    // Type filter
    const matchesType = filters.type === 'all' || property.type === filters.type;

    // Category filter
    const matchesCategory = filters.category === 'all' || property.category === filters.category;

    // Status filter
    const matchesStatus = filters.status === 'all' || property.status === filters.status;

    // District filter
    const matchesDistrict = filters.district === 'all' || 
      property.location.district.toLowerCase() === filters.district.toLowerCase();

    // Price range filter
    const matchesPriceRange = property.currency === 'USD' && 
      property.price >= filters.priceRange[0] && 
      property.price <= filters.priceRange[1];

    // Bedrooms filter
    const matchesBedrooms = filters.bedrooms === 'all' || 
      !property.details.bedrooms || 
      property.details.bedrooms === parseInt(filters.bedrooms);

    return matchesSearch && matchesType && matchesCategory && matchesStatus && 
           matchesDistrict && matchesPriceRange && matchesBedrooms;
  });

  const clearFilters = () => {
    setFilters({
      type: 'all',
      category: 'all',
      status: 'all',
      district: 'all',
      priceRange: [0, 1000000],
      bedrooms: 'all'
    });
    setSearchQuery('');
    setShowFilters(false);
  };

  const handleFilterChange = (key, value) => {
    setFilters(prev => ({
      ...prev,
      [key]: value
    }));
  };

  const getPropertyTypeIcon = (type) => {
    switch (type) {
      case 'villa':
      case 'house':
        return <Home className="w-4 h-4" />;
      case 'apartment':
        return <Building className="w-4 h-4" />;
      case 'building':
      case 'office':
        return <Building className="w-4 h-4" />;
      default:
        return <Square className="w-4 h-4" />;
    }
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 'for_sale':
        return 'bg-green-100 text-green-800';
      case 'for_rent':
        return 'bg-blue-100 text-blue-800';
      case 'sold':
        return 'bg-gray-100 text-gray-800';
      case 'rented':
        return 'bg-purple-100 text-purple-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  const formatStatus = (status) => {
    return status.replace('_', ' ').toUpperCase();
  };

  if (selectedProperty) {
    return (
      <PropertyDetails
        property={selectedProperty}
        onBack={() => setSelectedProperty(null)}
        onUpdate={(updatedProperty) => {
          setProperties(prev => 
            prev.map(p => p.id === updatedProperty.id ? updatedProperty : p)
          );
          setSelectedProperty(updatedProperty);
        }}
      />
    );
  }

  return (
    <div className="pb-4">
      {/* Header */}
      <div className="bg-black text-white p-4 m-4 rounded-lg">
        <h1 className="text-2xl font-bold mb-2">Properties in Rwanda</h1>
        <p className="text-gray-300">
          Invest in real estate back home - Buy, rent, or bid on properties
        </p>
      </div>

      {/* Search and Filters */}
      <div className="px-4 mb-4">
        <div className="flex items-center space-x-2 bg-white rounded-lg p-2 border border-gray-300">
          <Search className="w-4 h-4 text-gray-400" />
          <input
            type="text"
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            placeholder="Search properties by location, type..."
            className="flex-1 outline-none"
          />
          <button
            onClick={() => setShowFilters(!showFilters)}
            className="p-2 hover:bg-gray-100 rounded transition-colors"
          >
            <Filter className="w-4 h-4 text-gray-600" />
          </button>
        </div>

        {/* Filter Panel */}
        {showFilters && (
          <div className="mt-2 bg-white rounded-lg border border-gray-300 p-4">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-semibold">Filters</h3>
              <button
                onClick={() => setShowFilters(false)}
                className="p-1 hover:bg-gray-100 rounded"
              >
                <X className="w-4 h-4" />
              </button>
            </div>
            
            <div className="grid grid-cols-1 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Property Type</label>
                <select
                  value={filters.type}
                  onChange={(e) => handleFilterChange('type', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Types</option>
                  {propertyTypes.map(type => (
                    <option key={type} value={type} className="capitalize">
                      {type.replace('_', ' ')}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Category</label>
                <select
                  value={filters.category}
                  onChange={(e) => handleFilterChange('category', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Categories</option>
                  {propertyCategories.map(category => (
                    <option key={category} value={category} className="capitalize">
                      {category}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Status</label>
                <select
                  value={filters.status}
                  onChange={(e) => handleFilterChange('status', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Status</option>
                  {propertyStatuses.map(status => (
                    <option key={status} value={status}>
                      {formatStatus(status)}
                    </option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">District</label>
                <select
                  value={filters.district}
                  onChange={(e) => handleFilterChange('district', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Districts</option>
                  {rwandaDistricts.map(district => (
                    <option key={district} value={district}>{district}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Bedrooms</label>
                <select
                  value={filters.bedrooms}
                  onChange={(e) => handleFilterChange('bedrooms', e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">Any</option>
                  <option value="1">1 Bedroom</option>
                  <option value="2">2 Bedrooms</option>
                  <option value="3">3 Bedrooms</option>
                  <option value="4">4+ Bedrooms</option>
                </select>
              </div>

              <button
                onClick={clearFilters}
                className="w-full bg-gray-100 text-gray-700 py-2 rounded-lg hover:bg-gray-200 transition-colors"
              >
                Clear Filters
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Quick Stats */}
      <div className="px-4 mb-4">
        <div className="grid grid-cols-3 gap-2">
          <div className="bg-white p-3 rounded-lg border border-gray-300 text-center">
            <div className="text-2xl font-bold text-black">{stats.total}</div>
            <div className="text-xs text-gray-600">Total Properties</div>
          </div>
          <div className="bg-white p-3 rounded-lg border border-gray-300 text-center">
            <div className="text-2xl font-bold text-green-600">{stats.forSale}</div>
            <div className="text-xs text-gray-600">For Sale</div>
          </div>
          <div className="bg-white p-3 rounded-lg border border-gray-300 text-center">
            <div className="text-2xl font-bold text-blue-600">{stats.forRent}</div>
            <div className="text-xs text-gray-600">For Rent</div>
          </div>
        </div>
      </div>

      {/* Results Summary */}
      <div className="px-4 mb-4">
        <p className="text-sm text-gray-600">
          Showing {filteredProperties.length} of {properties.length} properties
        </p>
      </div>

      {/* Properties List */}
      <div className="px-4 space-y-4">
        {filteredProperties.length === 0 ? (
          <div className="text-center py-8 bg-white rounded-lg border border-gray-300">
            <Home className="w-12 h-12 text-gray-400 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-gray-900 mb-2">No properties found</h3>
            <p className="text-gray-600 mb-4">Try adjusting your search or filters</p>
            <button
              onClick={clearFilters}
              className="bg-black text-white px-4 py-2 rounded-lg hover:bg-gray-800 transition-colors"
            >
              Clear Filters
            </button>
          </div>
        ) : (
          filteredProperties.map((property) => (
            <div
              key={property.id}
              className="bg-white rounded-lg border border-gray-300 overflow-hidden cursor-pointer hover:shadow-md transition-shadow"
              onClick={() => setSelectedProperty(property)}
            >
              {/* Property Image */}
              <div className="relative h-48 bg-gray-200">
                <img
                  src={property.images[0]}
                  alt={property.title}
                  className="w-full h-full object-cover"
                />
                <div className="absolute top-2 left-2 flex space-x-2">
                  <span className={`px-2 py-1 rounded-full text-xs font-medium ${getStatusColor(property.status)}`}>
                    {formatStatus(property.status)}
                  </span>
                  {property.featured && (
                    <span className="bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full text-xs font-medium flex items-center">
                      <Star className="w-3 h-3 mr-1 fill-current" />
                      Featured
                    </span>
                  )}
                </div>
                <div className="absolute top-2 right-2 flex items-center space-x-1 bg-black/50 text-white px-2 py-1 rounded-full text-xs">
                  <Eye className="w-3 h-3" />
                  <span>{property.views}</span>
                </div>
                <div className="absolute bottom-2 right-2 bg-black/80 text-white px-3 py-1 rounded-lg font-semibold">
                  {formatPrice(property.price, property.currency)}
                  {property.priceType === 'monthly' && '/mo'}
                </div>
              </div>

              {/* Property Info */}
              <div className="p-4">
                <div className="flex items-start justify-between mb-2">
                  <div className="flex-1">
                    <h3 className="text-lg font-semibold text-gray-900 mb-1">{property.title}</h3>
                    <div className="flex items-center text-sm text-gray-600 mb-2">
                      <MapPin className="w-4 h-4 mr-1" />
                      <span>{property.location.neighborhood}, {property.location.district}</span>
                    </div>
                  </div>
                  <div className="flex items-center space-x-1">
                    {getPropertyTypeIcon(property.type)}
                    <span className="text-sm text-gray-600 capitalize">{property.type}</span>
                  </div>
                </div>

                {/* Property Details */}
                <div className="flex items-center space-x-4 text-sm text-gray-600 mb-3">
                  {property.details.bedrooms && (
                    <div className="flex items-center">
                      <Bed className="w-4 h-4 mr-1" />
                      <span>{property.details.bedrooms}</span>
                    </div>
                  )}
                  {property.details.bathrooms && (
                    <div className="flex items-center">
                      <Bath className="w-4 h-4 mr-1" />
                      <span>{property.details.bathrooms}</span>
                    </div>
                  )}
                  {property.details.parking && (
                    <div className="flex items-center">
                      <Car className="w-4 h-4 mr-1" />
                      <span>{property.details.parking}</span>
                    </div>
                  )}
                  {property.details.builtArea && (
                    <div className="flex items-center">
                      <Square className="w-4 h-4 mr-1" />
                      <span>{property.details.builtArea}m²</span>
                    </div>
                  )}
                </div>

                {/* Description */}
                <p className="text-gray-700 text-sm mb-4 line-clamp-2">
                  {property.description}
                </p>

                {/* Agent and Actions */}
                <div className="flex items-center justify-between pt-3 border-t border-gray-200">
                  <div className="text-xs text-gray-500">
                    By {property.agent.name}
                  </div>
                  <div className="flex items-center space-x-2">
                    <button className="p-2 hover:bg-gray-100 rounded-full transition-colors">
                      <Heart className="w-4 h-4 text-gray-400" />
                    </button>
                    <div className="flex items-center space-x-1 bg-gray-100 px-2 py-1 rounded-full text-xs text-gray-600">
                      <DollarSign className="w-3 h-3" />
                      <span>{property.bids.length} bids</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default PropertiesContent;