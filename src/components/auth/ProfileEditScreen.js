import React, { useState, useEffect } from 'react';
import { X, Calendar } from 'lucide-react';
import { availableInterests, availableProfilePictures } from '../../data/dummyUsers';

const ProfileEditScreen = ({ auth, onClose }) => {
  const [profileForm, setProfileForm] = useState({});
  const [profileSuccess, setProfileSuccess] = useState('');

  useEffect(() => {
    if (auth.currentUser) {
      setProfileForm({
        fullName: auth.currentUser.fullName || '',
        email: auth.currentUser.email || '',
        location: auth.currentUser.location || '',
        phone: auth.currentUser.phone || '',
        profession: auth.currentUser.profession || '',
        profileImage: auth.currentUser.profileImage || availableProfilePictures[0],
        interests: auth.currentUser.interests ? [...auth.currentUser.interests] : []
      });
    }
  }, [auth.currentUser]);

  const handleProfileSave = (e) => {
    e.preventDefault();
    auth.updateProfile(profileForm);
    setProfileSuccess('Profile updated successfully!');
    setTimeout(() => {
      onClose();
      setProfileSuccess('');
    }, 1500);
  };

  const toggleInterest = (interest) => {
    setProfileForm(prev => ({
      ...prev,
      interests: prev.interests.includes(interest)
        ? prev.interests.filter(i => i !== interest)
        : [...prev.interests, interest]
    }));
  };

  return (
    <div className="fixed inset-0 bg-gray-50 z-50 overflow-y-auto">
      <div className="bg-gradient-to-r from-blue-600 to-green-600 text-white p-4">
        <div className="flex items-center justify-between">
          <button onClick={onClose}>
            <X className="w-6 h-6" />
          </button>
          <h1 className="text-lg font-semibold">Edit Profile</h1>
          <div className="w-6"></div>
        </div>
      </div>

      <form onSubmit={handleProfileSave} className="p-4 space-y-6">
        {profileSuccess && (
          <div className="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded-lg text-sm">
            {profileSuccess}
          </div>
        )}

        {/* Profile Picture Selection */}
        <div>
          <h3 className="font-medium text-gray-900 mb-3">Profile Picture</h3>
          <div className="grid grid-cols-4 gap-3">
            {availableProfilePictures.map((pic, index) => (
              <button
                key={index}
                type="button"
                onClick={() => setProfileForm({...profileForm, profileImage: pic})}
                className={`relative rounded-full overflow-hidden ${
                  profileForm.profileImage === pic ? 'ring-4 ring-blue-500' : ''
                }`}
              >
                <img src={pic} alt={`Avatar ${index + 1}`} className="w-16 h-16 object-cover" />
                {profileForm.profileImage === pic && (
                  <div className="absolute inset-0 bg-blue-500 bg-opacity-20 flex items-center justify-center">
                    <div className="w-4 h-4 bg-blue-500 rounded-full flex items-center justify-center">
                      <span className="text-white text-xs">✓</span>
                    </div>
                  </div>
                )}
              </button>
            ))}
          </div>
        </div>

        {/* Basic Information */}
        <div className="space-y-4">
          <h3 className="font-medium text-gray-900">Basic Information</h3>
          
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Full Name
            </label>
            <input
              type="text"
              value={profileForm.fullName || ''}
              onChange={(e) => setProfileForm({...profileForm, fullName: e.target.value})}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Email
            </label>
            <input
              type="email"
              value={profileForm.email || ''}
              onChange={(e) => setProfileForm({...profileForm, email: e.target.value})}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Current Location
            </label>
            <input
              type="text"
              value={profileForm.location || ''}
              onChange={(e) => setProfileForm({...profileForm, location: e.target.value})}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              placeholder="City, Country"
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Phone Number
            </label>
            <input
              type="tel"
              value={profileForm.phone || ''}
              onChange={(e) => setProfileForm({...profileForm, phone: e.target.value})}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              placeholder="+1-xxx-xxx-xxxx"
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Profession
            </label>
            <input
              type="text"
              value={profileForm.profession || ''}
              onChange={(e) => setProfileForm({...profileForm, profession: e.target.value})}
              className="w-full p-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              placeholder="Your current job title"
            />
          </div>
        </div>

        {/* Interests Selection */}
        <div>
          <h3 className="font-medium text-gray-900 mb-3">Areas of Interest</h3>
          <p className="text-sm text-gray-600 mb-3">Select topics you're interested in (helps personalize your experience)</p>
          <div className="grid grid-cols-2 gap-2">
            {availableInterests.map(interest => (
              <button
                key={interest}
                type="button"
                onClick={() => toggleInterest(interest)}
                className={`p-2 rounded-lg text-sm font-medium transition-colors ${
                  profileForm.interests?.includes(interest)
                    ? 'bg-blue-100 text-blue-800 border border-blue-200'
                    : 'bg-gray-50 text-gray-700 border border-gray-200 hover:bg-gray-100'
                }`}
              >
                {interest}
              </button>
            ))}
          </div>
          <p className="text-xs text-gray-500 mt-2">
            Selected: {profileForm.interests?.length || 0} interests
          </p>
        </div>

        {/* Save Button */}
        <div className="pt-4">
          <button
            type="submit"
            className="w-full bg-blue-600 text-white py-3 px-4 rounded-lg font-medium hover:bg-blue-700 transition-colors"
          >
            Save Changes
          </button>
        </div>
      </form>
    </div>
  );
};

export default ProfileEditScreen;