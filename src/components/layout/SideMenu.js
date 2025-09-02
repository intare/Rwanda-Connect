import React, { useState } from 'react';
import { X, User, Bookmark, Settings } from 'lucide-react';
import SubscriptionBadge from '../subscription/SubscriptionBadge';

const SideMenu = ({ showMenu, setShowMenu, currentUser, onEditProfile, onLogout }) => {
  const [selectedRegion, setSelectedRegion] = useState('All Regions');

  if (!showMenu) return null;

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 z-50" onClick={() => setShowMenu(false)}>
      <div className="bg-white w-80 h-full" onClick={e => e.stopPropagation()}>
        <div className="p-4 border-b bg-black text-white">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-lg font-semibold">Menu</h2>
            <button onClick={() => setShowMenu(false)}>
              <X className="w-6 h-6" />
            </button>
          </div>
          {currentUser && (
            <div className="flex items-center space-x-3">
              <img
                src={currentUser.profileImage}
                alt={currentUser.fullName}
                className="w-12 h-12 rounded-full object-cover border-2 border-white"
              />
              <div className="flex-1">
                <h3 className="font-semibold">{currentUser.fullName}</h3>
                <p className="text-sm opacity-90">{currentUser.location}</p>
                <div className="mt-1">
                  <SubscriptionBadge user={currentUser} />
                </div>
              </div>
            </div>
          )}
        </div>
        <div className="p-4 space-y-4">
          <div className="space-y-2">
            <label className="text-sm font-medium text-black">Region</label>
            <select 
              value={selectedRegion}
              onChange={(e) => setSelectedRegion(e.target.value)}
              className="w-full p-2 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
            >
              <option>All Regions</option>
              <option>East Africa</option>
              <option>North America</option>
              <option>Europe</option>
              <option>Asia Pacific</option>
            </select>
          </div>
          <div className="space-y-3">
            <button 
              onClick={onEditProfile}
              className="w-full text-left p-3 rounded-lg hover:bg-gray-100 flex items-center space-x-3"
            >
              <User className="w-5 h-5 text-black" />
              <span className="text-black">Edit Profile</span>
            </button>
            <button className="w-full text-left p-3 rounded-lg hover:bg-gray-100 flex items-center space-x-3">
              <Bookmark className="w-5 h-5 text-black" />
              <span className="text-black">Bookmarks</span>
            </button>
            <button className="w-full text-left p-3 rounded-lg hover:bg-gray-100 flex items-center space-x-3">
              <Settings className="w-5 h-5 text-black" />
              <span className="text-black">Settings</span>
            </button>
            <button 
              onClick={onLogout}
              className="w-full text-left p-3 rounded-lg hover:bg-gray-100 flex items-center space-x-3 text-black border-t border-black mt-4 pt-4"
            >
              <User className="w-5 h-5" />
              <span>Sign Out</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SideMenu;