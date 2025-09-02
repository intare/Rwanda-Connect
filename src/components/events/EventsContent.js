import React, { useState } from 'react';
import { 
  Plus, 
  Calendar, 
  MapPin, 
  Users, 
  Star,
  Filter,
  Search,
  X,
  DollarSign,
  Globe
} from 'lucide-react';
import { 
  dummyEvents, 
  eventCategories, 
  eventTypes, 
  getUpcomingEvents, 
  getFeaturedEvents
} from '../../data/events';
import AddEventForm from './AddEventForm';

const EventsContent = () => {
  const [events, setEvents] = useState(dummyEvents);
  const [showAddForm, setShowAddForm] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('all');
  const [selectedType, setSelectedType] = useState('all');
  const [showFilters, setShowFilters] = useState(false);
  const [view, setView] = useState('all'); // all, featured, upcoming

  // Filter and search logic
  const filteredEvents = events.filter(event => {
    const matchesSearch = searchQuery === '' || 
      event.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      event.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
      event.location.city.toLowerCase().includes(searchQuery.toLowerCase());
    
    const matchesCategory = selectedCategory === 'all' || event.category === selectedCategory;
    const matchesType = selectedType === 'all' || event.type === selectedType;
    
    const matchesView = view === 'all' || 
      (view === 'featured' && event.featured) ||
      (view === 'upcoming' && event.status === 'upcoming');
    
    return matchesSearch && matchesCategory && matchesType && matchesView;
  });

  const handleAddEvent = (newEvent) => {
    const eventWithId = {
      ...newEvent,
      id: events.length + 1,
      registered: 0,
      status: 'upcoming',
      featured: false,
      createdAt: new Date().toISOString(),
      image: "/api/placeholder/400/200"
    };
    setEvents([eventWithId, ...events]);
    setShowAddForm(false);
  };

  const formatDate = (dateString) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
      weekday: 'short', 
      month: 'short', 
      day: 'numeric' 
    });
  };

  const formatTime = (timeString) => {
    const [hours, minutes] = timeString.split(':');
    const date = new Date();
    date.setHours(parseInt(hours), parseInt(minutes));
    return date.toLocaleTimeString('en-US', { 
      hour: 'numeric', 
      minute: '2-digit',
      hour12: true 
    });
  };

  const getStatusColor = (status) => {
    switch (status) {
      case 'upcoming': return 'bg-green-100 text-green-800';
      case 'completed': return 'bg-gray-100 text-gray-800';
      case 'cancelled': return 'bg-red-100 text-red-800';
      default: return 'bg-blue-100 text-blue-800';
    }
  };

  const clearFilters = () => {
    setSearchQuery('');
    setSelectedCategory('all');
    setSelectedType('all');
    setView('all');
    setShowFilters(false);
  };

  if (showAddForm) {
    return (
      <AddEventForm
        onSubmit={handleAddEvent}
        onCancel={() => setShowAddForm(false)}
      />
    );
  }

  return (
    <div className="pb-4">
      {/* Header */}
      <div className="bg-black text-white p-4 m-4 rounded-lg">
        <div className="flex items-center justify-between mb-4">
          <h1 className="text-2xl font-bold">Events</h1>
          <button
            onClick={() => setShowAddForm(true)}
            className="bg-white text-black px-4 py-2 rounded-lg font-medium flex items-center hover:bg-gray-100 transition-colors"
          >
            <Plus className="w-4 h-4 mr-2" />
            Add Event
          </button>
        </div>
        <p className="text-gray-300">
          Discover and create events for the Rwandan diaspora community
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
            placeholder="Search events..."
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
                <label className="block text-sm font-medium text-gray-700 mb-2">View</label>
                <select
                  value={view}
                  onChange={(e) => setView(e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Events</option>
                  <option value="upcoming">Upcoming</option>
                  <option value="featured">Featured</option>
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Category</label>
                <select
                  value={selectedCategory}
                  onChange={(e) => setSelectedCategory(e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Categories</option>
                  {eventCategories.map(category => (
                    <option key={category} value={category}>{category}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Type</label>
                <select
                  value={selectedType}
                  onChange={(e) => setSelectedType(e.target.value)}
                  className="w-full p-2 border border-gray-300 rounded-lg"
                >
                  <option value="all">All Types</option>
                  {eventTypes.map(type => (
                    <option key={type} value={type} className="capitalize">{type}</option>
                  ))}
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
            <div className="text-2xl font-bold text-black">{events.length}</div>
            <div className="text-xs text-gray-600">Total Events</div>
          </div>
          <div className="bg-white p-3 rounded-lg border border-gray-300 text-center">
            <div className="text-2xl font-bold text-green-600">{getUpcomingEvents().length}</div>
            <div className="text-xs text-gray-600">Upcoming</div>
          </div>
          <div className="bg-white p-3 rounded-lg border border-gray-300 text-center">
            <div className="text-2xl font-bold text-yellow-600">{getFeaturedEvents().length}</div>
            <div className="text-xs text-gray-600">Featured</div>
          </div>
        </div>
      </div>

      {/* Results Summary */}
      <div className="px-4 mb-4">
        <p className="text-sm text-gray-600">
          Showing {filteredEvents.length} of {events.length} events
        </p>
      </div>

      {/* Events List */}
      <div className="px-4 space-y-4">
        {filteredEvents.length === 0 ? (
          <div className="text-center py-8 bg-white rounded-lg border border-gray-300">
            <Calendar className="w-12 h-12 text-gray-400 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-gray-900 mb-2">No events found</h3>
            <p className="text-gray-600 mb-4">Try adjusting your search or filters</p>
            <button
              onClick={clearFilters}
              className="bg-black text-white px-4 py-2 rounded-lg hover:bg-gray-800 transition-colors"
            >
              Clear Filters
            </button>
          </div>
        ) : (
          filteredEvents.map((event) => (
            <div key={event.id} className="bg-white rounded-lg border border-gray-300 p-4">
              {/* Event Header */}
              <div className="flex items-start justify-between mb-3">
                <div className="flex-1">
                  <div className="flex items-center mb-2">
                    <h3 className="text-lg font-semibold text-gray-900 mr-2">{event.title}</h3>
                    {event.featured && (
                      <Star className="w-4 h-4 text-yellow-500 fill-current" />
                    )}
                  </div>
                  <div className="flex items-center space-x-4 text-sm text-gray-600">
                    <span className={`px-2 py-1 rounded-full text-xs font-medium ${getStatusColor(event.status)}`}>
                      {event.status}
                    </span>
                    <span className="bg-gray-100 text-gray-700 px-2 py-1 rounded-full text-xs font-medium">
                      {event.category}
                    </span>
                  </div>
                </div>
              </div>

              {/* Event Details */}
              <div className="space-y-2 mb-4">
                <div className="flex items-center text-sm text-gray-600">
                  <Calendar className="w-4 h-4 mr-2" />
                  <span>{formatDate(event.date)} at {formatTime(event.time)}</span>
                </div>
                
                <div className="flex items-center text-sm text-gray-600">
                  <MapPin className="w-4 h-4 mr-2" />
                  <span>{event.location.name}, {event.location.city}</span>
                </div>

                <div className="flex items-center text-sm text-gray-600">
                  <Users className="w-4 h-4 mr-2" />
                  <span>{event.registered} / {event.capacity} registered</span>
                </div>

                {event.price > 0 && (
                  <div className="flex items-center text-sm text-gray-600">
                    <DollarSign className="w-4 h-4 mr-2" />
                    <span>{event.price} {event.currency}</span>
                  </div>
                )}

                {event.location.city === 'Virtual' && (
                  <div className="flex items-center text-sm text-blue-600">
                    <Globe className="w-4 h-4 mr-2" />
                    <span>Virtual Event</span>
                  </div>
                )}
              </div>

              {/* Event Description */}
              <p className="text-gray-700 text-sm mb-4 line-clamp-2">
                {event.description}
              </p>

              {/* Event Tags */}
              <div className="flex flex-wrap gap-1 mb-4">
                {event.tags.slice(0, 3).map((tag, index) => (
                  <span
                    key={index}
                    className="bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs"
                  >
                    #{tag}
                  </span>
                ))}
                {event.tags.length > 3 && (
                  <span className="text-gray-500 text-xs">
                    +{event.tags.length - 3} more
                  </span>
                )}
              </div>

              {/* Action Buttons */}
              <div className="flex items-center justify-between pt-3 border-t border-gray-200">
                <div className="text-xs text-gray-500">
                  By {event.organizer.name}
                </div>
                <div className="flex space-x-2">
                  <button className="bg-gray-100 text-gray-700 px-3 py-1 rounded-lg text-sm hover:bg-gray-200 transition-colors">
                    Share
                  </button>
                  <button className="bg-black text-white px-3 py-1 rounded-lg text-sm hover:bg-gray-800 transition-colors">
                    {event.status === 'upcoming' ? 'Register' : 'View Details'}
                  </button>
                </div>
              </div>
            </div>
          ))
        )}
      </div>
    </div>
  );
};

export default EventsContent;