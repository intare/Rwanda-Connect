import React, { useState } from 'react';
import { 
  ArrowLeft, 
  Calendar, 
  MapPin, 
  Users, 
  Plus,
  X
} from 'lucide-react';
import { eventCategories, eventTypes } from '../../data/events';

const AddEventForm = ({ onSubmit, onCancel }) => {
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    type: 'networking',
    category: 'Professional',
    date: '',
    time: '',
    endTime: '',
    location: {
      name: '',
      address: '',
      city: '',
      country: ''
    },
    organizer: {
      name: '',
      email: '',
      phone: ''
    },
    capacity: 50,
    price: 0,
    currency: 'USD',
    tags: []
  });

  const [currentTag, setCurrentTag] = useState('');
  const [errors, setErrors] = useState({});

  const handleInputChange = (field, value) => {
    if (field.includes('.')) {
      const [parent, child] = field.split('.');
      setFormData(prev => ({
        ...prev,
        [parent]: {
          ...prev[parent],
          [child]: value
        }
      }));
    } else {
      setFormData(prev => ({
        ...prev,
        [field]: value
      }));
    }
    
    // Clear error when user starts typing
    if (errors[field]) {
      setErrors(prev => ({
        ...prev,
        [field]: ''
      }));
    }
  };

  const addTag = () => {
    if (currentTag.trim() && !formData.tags.includes(currentTag.trim().toLowerCase())) {
      setFormData(prev => ({
        ...prev,
        tags: [...prev.tags, currentTag.trim().toLowerCase()]
      }));
      setCurrentTag('');
    }
  };

  const removeTag = (tagToRemove) => {
    setFormData(prev => ({
      ...prev,
      tags: prev.tags.filter(tag => tag !== tagToRemove)
    }));
  };

  const validateForm = () => {
    const newErrors = {};

    if (!formData.title.trim()) newErrors.title = 'Event title is required';
    if (!formData.description.trim()) newErrors.description = 'Event description is required';
    if (!formData.date) newErrors.date = 'Event date is required';
    if (!formData.time) newErrors.time = 'Start time is required';
    if (!formData.location.name.trim()) newErrors['location.name'] = 'Venue name is required';
    if (!formData.location.city.trim()) newErrors['location.city'] = 'City is required';
    if (!formData.location.country.trim()) newErrors['location.country'] = 'Country is required';
    if (!formData.organizer.name.trim()) newErrors['organizer.name'] = 'Organizer name is required';
    if (!formData.organizer.email.trim()) newErrors['organizer.email'] = 'Organizer email is required';
    if (!formData.organizer.phone.trim()) newErrors['organizer.phone'] = 'Organizer phone is required';
    if (formData.capacity < 1) newErrors.capacity = 'Capacity must be at least 1';
    if (formData.price < 0) newErrors.price = 'Price cannot be negative';

    // Email validation
    if (formData.organizer.email && !/\S+@\S+\.\S+/.test(formData.organizer.email)) {
      newErrors['organizer.email'] = 'Please enter a valid email address';
    }

    // Date validation (can't be in the past)
    if (formData.date) {
      const eventDate = new Date(formData.date);
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      if (eventDate < today) {
        newErrors.date = 'Event date cannot be in the past';
      }
    }

    // End time validation (must be after start time)
    if (formData.time && formData.endTime) {
      if (formData.endTime <= formData.time) {
        newErrors.endTime = 'End time must be after start time';
      }
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (validateForm()) {
      onSubmit(formData);
    }
  };

  const currencies = ['USD', 'CAD', 'GBP', 'EUR', 'AUD', 'AED', 'RWF'];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-black text-white p-4">
        <div className="flex items-center mb-4">
          <button
            onClick={onCancel}
            className="mr-4 p-2 rounded-full hover:bg-gray-800 transition-colors"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">Add New Event</h1>
        </div>
        <p className="text-gray-300">Create an event for the Rwandan community</p>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="p-4 space-y-6">
        {/* Basic Information */}
        <div className="bg-white rounded-lg p-6 border border-gray-300">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Basic Information</h2>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Event Title *
              </label>
              <input
                type="text"
                value={formData.title}
                onChange={(e) => handleInputChange('title', e.target.value)}
                placeholder="e.g., Rwanda Connect Toronto Networking Night"
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors.title ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors.title && <p className="text-red-500 text-sm mt-1">{errors.title}</p>}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Description *
              </label>
              <textarea
                value={formData.description}
                onChange={(e) => handleInputChange('description', e.target.value)}
                placeholder="Describe your event, what attendees can expect..."
                rows={4}
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors.description ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors.description && <p className="text-red-500 text-sm mt-1">{errors.description}</p>}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Category *
                </label>
                <select
                  value={formData.category}
                  onChange={(e) => handleInputChange('category', e.target.value)}
                  className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                >
                  {eventCategories.map(category => (
                    <option key={category} value={category}>{category}</option>
                  ))}
                </select>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Type *
                </label>
                <select
                  value={formData.type}
                  onChange={(e) => handleInputChange('type', e.target.value)}
                  className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                >
                  {eventTypes.map(type => (
                    <option key={type} value={type} className="capitalize">{type}</option>
                  ))}
                </select>
              </div>
            </div>
          </div>
        </div>

        {/* Date and Time */}
        <div className="bg-white rounded-lg p-6 border border-gray-300">
          <h2 className="text-lg font-semibold text-gray-900 mb-4 flex items-center">
            <Calendar className="w-5 h-5 mr-2" />
            Date & Time
          </h2>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Event Date *
              </label>
              <input
                type="date"
                value={formData.date}
                onChange={(e) => handleInputChange('date', e.target.value)}
                min={new Date().toISOString().split('T')[0]}
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors.date ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors.date && <p className="text-red-500 text-sm mt-1">{errors.date}</p>}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Start Time *
                </label>
                <input
                  type="time"
                  value={formData.time}
                  onChange={(e) => handleInputChange('time', e.target.value)}
                  className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                    errors.time ? 'border-red-500' : 'border-gray-300'
                  }`}
                />
                {errors.time && <p className="text-red-500 text-sm mt-1">{errors.time}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  End Time
                </label>
                <input
                  type="time"
                  value={formData.endTime}
                  onChange={(e) => handleInputChange('endTime', e.target.value)}
                  className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                    errors.endTime ? 'border-red-500' : 'border-gray-300'
                  }`}
                />
                {errors.endTime && <p className="text-red-500 text-sm mt-1">{errors.endTime}</p>}
              </div>
            </div>
          </div>
        </div>

        {/* Location */}
        <div className="bg-white rounded-lg p-6 border border-gray-300">
          <h2 className="text-lg font-semibold text-gray-900 mb-4 flex items-center">
            <MapPin className="w-5 h-5 mr-2" />
            Location
          </h2>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Venue Name *
              </label>
              <input
                type="text"
                value={formData.location.name}
                onChange={(e) => handleInputChange('location.name', e.target.value)}
                placeholder="e.g., Four Points by Sheraton or Virtual Event"
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors['location.name'] ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors['location.name'] && <p className="text-red-500 text-sm mt-1">{errors['location.name']}</p>}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Address
              </label>
              <input
                type="text"
                value={formData.location.address}
                onChange={(e) => handleInputChange('location.address', e.target.value)}
                placeholder="Street address (optional for virtual events)"
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  City *
                </label>
                <input
                  type="text"
                  value={formData.location.city}
                  onChange={(e) => handleInputChange('location.city', e.target.value)}
                  placeholder="e.g., Toronto, London, Virtual"
                  className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                    errors['location.city'] ? 'border-red-500' : 'border-gray-300'
                  }`}
                />
                {errors['location.city'] && <p className="text-red-500 text-sm mt-1">{errors['location.city']}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Country *
                </label>
                <input
                  type="text"
                  value={formData.location.country}
                  onChange={(e) => handleInputChange('location.country', e.target.value)}
                  placeholder="e.g., Canada, UK, Global"
                  className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                    errors['location.country'] ? 'border-red-500' : 'border-gray-300'
                  }`}
                />
                {errors['location.country'] && <p className="text-red-500 text-sm mt-1">{errors['location.country']}</p>}
              </div>
            </div>
          </div>
        </div>

        {/* Event Details */}
        <div className="bg-white rounded-lg p-6 border border-gray-300">
          <h2 className="text-lg font-semibold text-gray-900 mb-4 flex items-center">
            <Users className="w-5 h-5 mr-2" />
            Event Details
          </h2>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Capacity *
              </label>
              <input
                type="number"
                min="1"
                value={formData.capacity}
                onChange={(e) => handleInputChange('capacity', parseInt(e.target.value) || 0)}
                placeholder="Maximum number of attendees"
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors.capacity ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors.capacity && <p className="text-red-500 text-sm mt-1">{errors.capacity}</p>}
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Ticket Price
                </label>
                <input
                  type="number"
                  min="0"
                  step="0.01"
                  value={formData.price}
                  onChange={(e) => handleInputChange('price', parseFloat(e.target.value) || 0)}
                  placeholder="0 for free events"
                  className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                    errors.price ? 'border-red-500' : 'border-gray-300'
                  }`}
                />
                {errors.price && <p className="text-red-500 text-sm mt-1">{errors.price}</p>}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Currency
                </label>
                <select
                  value={formData.currency}
                  onChange={(e) => handleInputChange('currency', e.target.value)}
                  className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                >
                  {currencies.map(currency => (
                    <option key={currency} value={currency}>{currency}</option>
                  ))}
                </select>
              </div>
            </div>
          </div>
        </div>

        {/* Organizer Information */}
        <div className="bg-white rounded-lg p-6 border border-gray-300">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Organizer Information</h2>
          
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Organizer Name *
              </label>
              <input
                type="text"
                value={formData.organizer.name}
                onChange={(e) => handleInputChange('organizer.name', e.target.value)}
                placeholder="Your full name or organization"
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors['organizer.name'] ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors['organizer.name'] && <p className="text-red-500 text-sm mt-1">{errors['organizer.name']}</p>}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Contact Email *
              </label>
              <input
                type="email"
                value={formData.organizer.email}
                onChange={(e) => handleInputChange('organizer.email', e.target.value)}
                placeholder="your@email.com"
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors['organizer.email'] ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors['organizer.email'] && <p className="text-red-500 text-sm mt-1">{errors['organizer.email']}</p>}
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Contact Phone *
              </label>
              <input
                type="tel"
                value={formData.organizer.phone}
                onChange={(e) => handleInputChange('organizer.phone', e.target.value)}
                placeholder="+1-xxx-xxx-xxxx"
                className={`w-full px-4 py-3 border rounded-lg focus:ring-2 focus:ring-black focus:border-black ${
                  errors['organizer.phone'] ? 'border-red-500' : 'border-gray-300'
                }`}
              />
              {errors['organizer.phone'] && <p className="text-red-500 text-sm mt-1">{errors['organizer.phone']}</p>}
            </div>
          </div>
        </div>

        {/* Tags */}
        <div className="bg-white rounded-lg p-6 border border-gray-300">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Tags</h2>
          
          <div className="space-y-4">
            <div className="flex space-x-2">
              <input
                type="text"
                value={currentTag}
                onChange={(e) => setCurrentTag(e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && (e.preventDefault(), addTag())}
                placeholder="Add tags (e.g., networking, business)"
                className="flex-1 px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
              />
              <button
                type="button"
                onClick={addTag}
                className="bg-black text-white px-4 py-3 rounded-lg hover:bg-gray-800 transition-colors"
              >
                <Plus className="w-4 h-4" />
              </button>
            </div>

            {formData.tags.length > 0 && (
              <div className="flex flex-wrap gap-2">
                {formData.tags.map((tag, index) => (
                  <span
                    key={index}
                    className="bg-gray-100 text-gray-700 px-3 py-1 rounded-full text-sm flex items-center"
                  >
                    #{tag}
                    <button
                      type="button"
                      onClick={() => removeTag(tag)}
                      className="ml-2 hover:text-red-600"
                    >
                      <X className="w-3 h-3" />
                    </button>
                  </span>
                ))}
              </div>
            )}
          </div>
        </div>

        {/* Submit Buttons */}
        <div className="flex space-x-4 pt-6">
          <button
            type="button"
            onClick={onCancel}
            className="flex-1 bg-gray-100 text-gray-700 py-3 px-6 rounded-lg font-medium hover:bg-gray-200 transition-colors"
          >
            Cancel
          </button>
          <button
            type="submit"
            className="flex-1 bg-black text-white py-3 px-6 rounded-lg font-medium hover:bg-gray-800 transition-colors"
          >
            Create Event
          </button>
        </div>
      </form>
    </div>
  );
};

export default AddEventForm;