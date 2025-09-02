import React from 'react';
import { Home, Briefcase, BookOpen, Users } from 'lucide-react';

const BottomNav = ({ activeTab, setActiveTab }) => {
  const navItems = [
    { key: 'home', icon: Home, label: 'Home' },
    { key: 'opportunities', icon: Briefcase, label: 'Opportunities' },
    { key: 'playbook', icon: BookOpen, label: 'Playbook' },
    { key: 'community', icon: Users, label: 'Community' }
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-black">
      <div className="grid grid-cols-4 p-2">
        {navItems.map(({ key, icon: Icon, label }) => (
          <button
            key={key}
            onClick={() => setActiveTab(key)}
            className={`flex flex-col items-center space-y-1 py-2 px-3 rounded-lg ${
              activeTab === key 
                ? 'text-white bg-black' 
                : 'text-gray-600 hover:bg-gray-100 hover:text-black'
            }`}
          >
            <Icon className="w-5 h-5" />
            <span className="text-xs">{label}</span>
          </button>
        ))}
      </div>
    </div>
  );
};

export default BottomNav;