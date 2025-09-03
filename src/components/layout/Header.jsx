import React from 'react';
import { Menu, Bell, Search, Filter } from 'lucide-react';

const Header = ({ 
  currentUser, 
  notifications, 
  searchQuery, 
  setSearchQuery, 
  setShowMenu, 
  setShowFilters, 
  getActiveFilterCount 
}) => {
  return (
    <div className="bg-black text-white p-4">
      <div className="flex items-center justify-between mb-4">
        <button onClick={() => setShowMenu(true)}>
          <Menu className="w-6 h-6" />
        </button>
        <div className="flex items-center space-x-2">
          <img 
            src="/logo.jpeg" 
            alt="Rwanda Connect" 
            className="w-8 h-8 object-contain"
            onError={(e) => {
              e.target.style.display = 'none';
              e.target.nextSibling.style.display = 'block';
            }}
          />
          <h1 className="text-xl font-bold">Rwanda Connect</h1>
        </div>
        <div className="flex items-center space-x-3">
          <button className="relative">
            <Bell className="w-6 h-6" />
            {notifications > 0 && (
              <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full w-5 h-5 flex items-center justify-center">
                {notifications}
              </span>
            )}
          </button>
          <button onClick={() => setShowMenu(true)} className="flex items-center space-x-2">
            <img
              src={currentUser?.profileImage}
              alt={currentUser?.fullName}
              className="w-8 h-8 rounded-full object-cover border-2 border-white"
            />
          </button>
        </div>
      </div>
      
      <div className="flex items-center space-x-2 bg-gray-800 rounded-lg p-2">
        <Search className="w-4 h-4 text-gray-300" />
        <input
          type="text"
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          placeholder="Search news, opportunities..."
          className="flex-1 bg-transparent text-white placeholder-gray-300 outline-none"
        />
        <button 
          onClick={() => setShowFilters(true)}
          className="relative"
        >
          <Filter className="w-4 h-4 text-gray-300" />
          {getActiveFilterCount() > 0 && (
            <span className="absolute -top-1 -right-1 bg-white text-black text-xs rounded-full w-4 h-4 flex items-center justify-center font-medium">
              {getActiveFilterCount()}
            </span>
          )}
        </button>
      </div>
    </div>
  );
};

export default Header;