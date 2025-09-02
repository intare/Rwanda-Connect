import React, { useState } from 'react';
import {
  ArrowLeft,
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
  Phone,
  Mail,
  Calendar,
  User,
  CheckCircle,
  AlertCircle
} from 'lucide-react';
import { formatPrice } from '../../data/properties';

const PropertyDetails = ({ property, onBack, onUpdate }) => {
  const [activeImageIndex, setActiveImageIndex] = useState(0);
  const [showBidForm, setShowBidForm] = useState(false);
  const [bidAmount, setBidAmount] = useState(property.price * 0.9);
  const [bidderName, setBidderName] = useState('');
  const [bidderEmail, setBidderEmail] = useState('');
  const [bidderPhone, setBidderPhone] = useState('');
  const [showContactAgent, setShowContactAgent] = useState(false);
  const [isFavorited, setIsFavorited] = useState(false);

  const getPropertyTypeIcon = (type) => {
    switch (type) {
      case 'villa':
      case 'house':
        return <Home className="w-5 h-5" />;
      case 'apartment':
        return <Building className="w-5 h-5" />;
      case 'building':
      case 'office':
        return <Building className="w-5 h-5" />;
      default:
        return <Square className="w-5 h-5" />;
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

  const handleBidSubmit = (e) => {
    e.preventDefault();
    
    if (!bidderName || !bidderEmail || !bidderPhone || bidAmount <= 0) {
      alert('Please fill in all fields');
      return;
    }

    if (bidAmount >= property.price) {
      alert('Bid amount must be less than the asking price');
      return;
    }

    const newBid = {
      id: property.bids.length + 1,
      bidder: bidderName,
      amount: bidAmount,
      currency: property.currency,
      date: new Date().toISOString(),
      status: 'active',
      email: bidderEmail,
      phone: bidderPhone
    };

    const updatedProperty = {
      ...property,
      bids: [...property.bids, newBid],
      updatedAt: new Date().toISOString()
    };

    onUpdate(updatedProperty);
    setShowBidForm(false);
    setBidderName('');
    setBidderEmail('');
    setBidderPhone('');
    setBidAmount(property.price * 0.9);
    alert('Your bid has been submitted successfully!');
  };

  const handleBuyNow = () => {
    if (window.confirm(`Are you sure you want to buy this property for ${formatPrice(property.price, property.currency)}?`)) {
      alert('Purchase initiated! The agent will contact you to complete the transaction.');
      setShowContactAgent(true);
    }
  };

  const toggleFavorite = () => {
    setIsFavorited(!isFavorited);
    const updatedProperty = {
      ...property,
      favorites: isFavorited ? property.favorites - 1 : property.favorites + 1
    };
    onUpdate(updatedProperty);
  };

  return (
    <div className="pb-20">
      {/* Header */}
      <div className="sticky top-0 bg-white border-b border-gray-200 p-4 z-10">
        <div className="flex items-center justify-between">
          <button
            onClick={onBack}
            className="p-2 hover:bg-gray-100 rounded-full transition-colors"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <button
            onClick={toggleFavorite}
            className="p-2 hover:bg-gray-100 rounded-full transition-colors"
          >
            <Heart className={`w-5 h-5 ${isFavorited ? 'fill-red-500 text-red-500' : 'text-gray-600'}`} />
          </button>
        </div>
      </div>

      {/* Image Gallery */}
      <div className="relative">
        <div className="h-64 bg-gray-200 overflow-hidden">
          <img
            src={property.images[activeImageIndex]}
            alt={property.title}
            className="w-full h-full object-cover"
          />
        </div>
        
        {/* Image Indicators */}
        {property.images.length > 1 && (
          <div className="absolute bottom-4 left-1/2 transform -translate-x-1/2 flex space-x-2">
            {property.images.map((_, index) => (
              <button
                key={index}
                onClick={() => setActiveImageIndex(index)}
                className={`w-2 h-2 rounded-full ${
                  index === activeImageIndex ? 'bg-white' : 'bg-white/50'
                }`}
              />
            ))}
          </div>
        )}

        {/* Property Status and Views */}
        <div className="absolute top-4 left-4 flex space-x-2">
          <span className={`px-3 py-1 rounded-full text-sm font-medium ${getStatusColor(property.status)}`}>
            {formatStatus(property.status)}
          </span>
          {property.featured && (
            <span className="bg-yellow-100 text-yellow-800 px-3 py-1 rounded-full text-sm font-medium flex items-center">
              <Star className="w-3 h-3 mr-1 fill-current" />
              Featured
            </span>
          )}
        </div>

        <div className="absolute top-4 right-4 flex items-center space-x-1 bg-black/50 text-white px-3 py-1 rounded-full text-sm">
          <Eye className="w-4 h-4" />
          <span>{property.views}</span>
        </div>
      </div>

      {/* Property Info */}
      <div className="p-4">
        {/* Title and Price */}
        <div className="mb-4">
          <div className="flex items-start justify-between mb-2">
            <div className="flex-1">
              <h1 className="text-2xl font-bold text-gray-900 mb-2">{property.title}</h1>
              <div className="flex items-center text-gray-600 mb-2">
                <MapPin className="w-4 h-4 mr-1" />
                <span>{property.location.neighborhood}, {property.location.district}</span>
              </div>
            </div>
            <div className="flex items-center space-x-2">
              {getPropertyTypeIcon(property.type)}
              <span className="text-sm text-gray-600 capitalize">{property.type}</span>
            </div>
          </div>
          
          <div className="bg-black text-white p-4 rounded-lg">
            <div className="text-3xl font-bold">
              {formatPrice(property.price, property.currency)}
              {property.priceType === 'monthly' && <span className="text-lg">/mo</span>}
            </div>
          </div>
        </div>

        {/* Property Details */}
        <div className="bg-gray-50 rounded-lg p-4 mb-6">
          <h3 className="font-semibold mb-3">Property Details</h3>
          <div className="grid grid-cols-2 gap-4">
            {property.details.bedrooms && (
              <div className="flex items-center">
                <Bed className="w-4 h-4 mr-2 text-gray-600" />
                <span className="text-sm">{property.details.bedrooms} Bedrooms</span>
              </div>
            )}
            {property.details.bathrooms && (
              <div className="flex items-center">
                <Bath className="w-4 h-4 mr-2 text-gray-600" />
                <span className="text-sm">{property.details.bathrooms} Bathrooms</span>
              </div>
            )}
            {property.details.parking && (
              <div className="flex items-center">
                <Car className="w-4 h-4 mr-2 text-gray-600" />
                <span className="text-sm">{property.details.parking} Parking</span>
              </div>
            )}
            {property.details.builtArea && (
              <div className="flex items-center">
                <Square className="w-4 h-4 mr-2 text-gray-600" />
                <span className="text-sm">{property.details.builtArea}m² Built</span>
              </div>
            )}
            {property.details.landSize && (
              <div className="flex items-center">
                <Square className="w-4 h-4 mr-2 text-gray-600" />
                <span className="text-sm">{property.details.landSize}m² Land</span>
              </div>
            )}
            {property.details.yearBuilt && (
              <div className="flex items-center">
                <Calendar className="w-4 h-4 mr-2 text-gray-600" />
                <span className="text-sm">Built {property.details.yearBuilt}</span>
              </div>
            )}
          </div>
        </div>

        {/* Description */}
        <div className="mb-6">
          <h3 className="font-semibold mb-3">Description</h3>
          <p className="text-gray-700 leading-relaxed">{property.description}</p>
        </div>

        {/* Features */}
        <div className="mb-6">
          <h3 className="font-semibold mb-3">Features</h3>
          <div className="space-y-2">
            {property.features.map((feature, index) => (
              <div key={index} className="flex items-center">
                <CheckCircle className="w-4 h-4 text-green-600 mr-2 flex-shrink-0" />
                <span className="text-sm text-gray-700">{feature}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Location Details */}
        <div className="mb-6">
          <h3 className="font-semibold mb-3">Location</h3>
          <div className="bg-gray-50 rounded-lg p-4">
            <div className="space-y-2 text-sm">
              <div><strong>City:</strong> {property.location.city}</div>
              <div><strong>District:</strong> {property.location.district}</div>
              <div><strong>Sector:</strong> {property.location.sector}</div>
              <div><strong>Neighborhood:</strong> {property.location.neighborhood}</div>
              {property.location.province && (
                <div><strong>Province:</strong> {property.location.province}</div>
              )}
            </div>
          </div>
        </div>

        {/* Current Bids */}
        {property.bids.length > 0 && (
          <div className="mb-6">
            <h3 className="font-semibold mb-3">Current Bids ({property.bids.length})</h3>
            <div className="space-y-2">
              {property.bids.slice(0, 3).map((bid) => (
                <div key={bid.id} className="flex items-center justify-between bg-gray-50 rounded-lg p-3">
                  <div>
                    <div className="font-medium">{bid.bidder}</div>
                    <div className="text-xs text-gray-600">
                      {new Date(bid.date).toLocaleDateString()}
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="font-bold">{formatPrice(bid.amount, bid.currency)}</div>
                    <div className={`text-xs px-2 py-1 rounded ${
                      bid.status === 'active' ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'
                    }`}>
                      {bid.status}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* Agent Info */}
        <div className="mb-6">
          <h3 className="font-semibold mb-3">Listed by</h3>
          <div className="bg-gray-50 rounded-lg p-4">
            <div className="flex items-start justify-between">
              <div className="flex-1">
                <div className="font-medium">{property.agent.name}</div>
                <div className="text-sm text-gray-600 mb-2">{property.agent.company}</div>
                <div className="text-xs text-gray-500">License: {property.agent.license}</div>
              </div>
              <button
                onClick={() => setShowContactAgent(!showContactAgent)}
                className="bg-black text-white px-3 py-2 rounded-lg text-sm hover:bg-gray-800 transition-colors"
              >
                Contact Agent
              </button>
            </div>
            
            {showContactAgent && (
              <div className="mt-4 pt-4 border-t border-gray-200">
                <div className="space-y-2 text-sm">
                  <div className="flex items-center">
                    <Phone className="w-4 h-4 mr-2" />
                    <a href={`tel:${property.agent.phone}`} className="text-blue-600 hover:underline">
                      {property.agent.phone}
                    </a>
                  </div>
                  <div className="flex items-center">
                    <Mail className="w-4 h-4 mr-2" />
                    <a href={`mailto:${property.agent.email}`} className="text-blue-600 hover:underline">
                      {property.agent.email}
                    </a>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>

      {/* Bid Form Modal */}
      {showBidForm && (
        <div className="fixed inset-0 bg-black/50 z-50 flex items-center justify-center p-4">
          <div className="bg-white rounded-lg w-full max-w-md max-h-[90vh] overflow-y-auto">
            <div className="p-4 border-b border-gray-200">
              <div className="flex items-center justify-between">
                <h3 className="text-lg font-semibold">Place Your Bid</h3>
                <button
                  onClick={() => setShowBidForm(false)}
                  className="p-2 hover:bg-gray-100 rounded-full"
                >
                  <ArrowLeft className="w-5 h-5" />
                </button>
              </div>
            </div>
            
            <form onSubmit={handleBidSubmit} className="p-4 space-y-4">
              <div className="bg-gray-50 rounded-lg p-3">
                <div className="text-sm text-gray-600 mb-1">Asking Price</div>
                <div className="text-xl font-bold">{formatPrice(property.price, property.currency)}</div>
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">
                  Your Bid Amount ({property.currency})
                </label>
                <input
                  type="number"
                  value={bidAmount}
                  onChange={(e) => setBidAmount(parseInt(e.target.value))}
                  max={property.price - 1}
                  min={1}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
                <input
                  type="text"
                  value={bidderName}
                  onChange={(e) => setBidderName(e.target.value)}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Email</label>
                <input
                  type="email"
                  value={bidderEmail}
                  onChange={(e) => setBidderEmail(e.target.value)}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  required
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-2">Phone Number</label>
                <input
                  type="tel"
                  value={bidderPhone}
                  onChange={(e) => setBidderPhone(e.target.value)}
                  className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  required
                />
              </div>

              <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-3">
                <div className="flex items-start">
                  <AlertCircle className="w-5 h-5 text-yellow-600 mr-2 mt-0.5 flex-shrink-0" />
                  <div className="text-sm text-yellow-800">
                    Your bid must be less than the asking price. The agent will review and respond within 24 hours.
                  </div>
                </div>
              </div>

              <div className="flex space-x-3">
                <button
                  type="button"
                  onClick={() => setShowBidForm(false)}
                  className="flex-1 bg-gray-100 text-gray-700 py-3 rounded-lg font-medium hover:bg-gray-200 transition-colors"
                >
                  Cancel
                </button>
                <button
                  type="submit"
                  className="flex-1 bg-black text-white py-3 rounded-lg font-medium hover:bg-gray-800 transition-colors"
                >
                  Submit Bid
                </button>
              </div>
            </form>
          </div>
        </div>
      )}

      {/* Action Buttons */}
      {property.status === 'for_sale' && (
        <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 p-4">
          <div className="flex space-x-3">
            <button
              onClick={() => setShowBidForm(true)}
              className="flex-1 bg-gray-100 text-gray-900 py-3 rounded-lg font-medium hover:bg-gray-200 transition-colors flex items-center justify-center"
            >
              <DollarSign className="w-4 h-4 mr-2" />
              Place Bid
            </button>
            <button
              onClick={handleBuyNow}
              className="flex-1 bg-black text-white py-3 rounded-lg font-medium hover:bg-gray-800 transition-colors"
            >
              Buy Now
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default PropertyDetails;