import React, { useState } from 'react';
import { useAuth } from './data/useAuth';
import LoginScreen from './components/auth/LoginScreen';
import SubscriptionScreen from './components/auth/SubscriptionScreen';
import PaymentMethodScreen from './components/auth/PaymentMethodScreen';
import ProfileEditScreen from './components/auth/ProfileEditScreen';
import Header from './components/layout/Header';
import SideMenu from './components/layout/SideMenu';
import BottomNav from './components/layout/BottomNav';
import HomeContent from './components/home/HomeContent';
import OpportunitiesContent from './components/home/OpportunitiesContent';
import PlaybookContent from './components/home/PlaybookContent';
import FilterPanel from './components/community/FilterPanel';
import CommunityContent from './components/community/CommunityContent';
import EventsContent from './components/events/EventsContent';
import PropertiesContent from './components/properties/PropertiesContent';

const App = () => {
  // Main app state
  const [activeTab, setActiveTab] = useState('home');
  const [notifications, setNotifications] = useState(3);
  const [showMenu, setShowMenu] = useState(false);
  const [showProfileEdit, setShowProfileEdit] = useState(false);
  const [showSubscription, setShowSubscription] = useState(false);
  const [showPayment, setShowPayment] = useState(false);
  const [selectedPlan, setSelectedPlan] = useState(null);
  const [bookmarkedItems, setBookmarkedItems] = useState(new Set());
  
  // Search and filtering states
  const [searchQuery, setSearchQuery] = useState('');
  const [showFilters, setShowFilters] = useState(false);
  const [activeFilters, setActiveFilters] = useState({
    categories: [],
    salaryRange: [0, 200000],
    locations: [],
    deadlines: [],
    industries: []
  });
  const [sortBy, setSortBy] = useState('recent');

  // Custom hook for authentication
  const auth = useAuth();

  // Bookmark functionality
  const toggleBookmark = (id, type) => {
    const key = `${type}-${id}`;
    setBookmarkedItems(prev => {
      const newSet = new Set(prev);
      if (newSet.has(key)) {
        newSet.delete(key);
      } else {
        newSet.add(key);
      }
      return newSet;
    });
  };

  // Profile editing functions
  const openProfileEdit = () => {
    setShowProfileEdit(true);
    setShowMenu(false);
  };

  const closeProfileEdit = () => {
    setShowProfileEdit(false);
  };

  // Filter functions
  const resetFilters = () => {
    setActiveFilters({
      categories: [],
      salaryRange: [0, 200000],
      locations: [],
      deadlines: [],
      industries: []
    });
    setSearchQuery('');
    setSortBy('recent');
  };

  const applyFilter = (filterType, value) => {
    setActiveFilters(prev => {
      const newFilters = { ...prev };
      if (filterType === 'salaryRange') {
        newFilters.salaryRange = value;
      } else {
        if (newFilters[filterType].includes(value)) {
          newFilters[filterType] = newFilters[filterType].filter(item => item !== value);
        } else {
          newFilters[filterType] = [...newFilters[filterType], value];
        }
      }
      return newFilters;
    });
  };

  const getActiveFilterCount = () => {
    return activeFilters.categories.length + 
           activeFilters.locations.length + 
           activeFilters.industries.length + 
           activeFilters.deadlines.length +
           (activeFilters.salaryRange[0] > 0 || activeFilters.salaryRange[1] < 200000 ? 1 : 0);
  };

  // Enhanced logout that also closes menus
  const handleLogout = () => {
    auth.handleLogout();
    setShowMenu(false);
    setShowProfileEdit(false);
    setShowSubscription(false);
    setShowPayment(false);
    setSelectedPlan(null);
  };

  // Subscription handlers
  const handleSubscriptionComplete = () => {
    setShowSubscription(false);
  };

  const handleSubscriptionSkip = () => {
    setShowSubscription(false);
  };

  const handlePlanSelected = (plan) => {
    if (plan.price > 0) {
      setSelectedPlan(plan);
      setShowSubscription(false);
      setShowPayment(true);
    } else {
      // Free trial, no payment needed
      handleSubscriptionComplete();
    }
  };

  // Payment handlers
  const handlePaymentComplete = () => {
    setShowPayment(false);
    setSelectedPlan(null);
  };

  const handlePaymentBack = () => {
    setShowPayment(false);
    setShowSubscription(true);
    setSelectedPlan(null);
  };

  // Check if user needs to see subscription screen
  React.useEffect(() => {
    if (auth.isAuthenticated && 
        auth.currentUser && 
        !auth.currentUser.subscription && 
        !showSubscription && 
        !showPayment) {
      setShowSubscription(true);
    }
  }, [auth.isAuthenticated, auth.currentUser, showSubscription, showPayment]);

  // Filter object to pass to components
  const filters = {
    searchQuery,
    setSearchQuery,
    showFilters,
    setShowFilters,
    activeFilters,
    setActiveFilters,
    sortBy,
    setSortBy,
    resetFilters,
    applyFilter,
    getActiveFilterCount
  };

  return (
    <div className="max-w-sm mx-auto bg-gray-50 min-h-screen relative">
      {!auth.isAuthenticated ? (
        <LoginScreen auth={auth} />
      ) : showPayment && selectedPlan ? (
        <PaymentMethodScreen
          selectedPlan={selectedPlan}
          onBack={handlePaymentBack}
          onComplete={handlePaymentComplete}
          auth={auth}
        />
      ) : showSubscription ? (
        <SubscriptionScreen 
          auth={auth} 
          onComplete={handleSubscriptionComplete}
          onSkip={handleSubscriptionSkip}
          onPlanSelected={handlePlanSelected}
        />
      ) : (
        <>
          {showProfileEdit && (
            <ProfileEditScreen 
              auth={auth} 
              onClose={closeProfileEdit}
            />
          )}
          {showFilters && <FilterPanel filters={filters} />}
          
          <Header 
            currentUser={auth.currentUser}
            notifications={notifications}
            searchQuery={searchQuery}
            setSearchQuery={setSearchQuery}
            setShowMenu={setShowMenu}
            setShowFilters={setShowFilters}
            getActiveFilterCount={getActiveFilterCount}
          />
          
          <SideMenu 
            showMenu={showMenu}
            setShowMenu={setShowMenu}
            currentUser={auth.currentUser}
            onEditProfile={openProfileEdit}
            onLogout={handleLogout}
          />
          
          <div className="pb-20">
            {activeTab === 'home' && (
              <HomeContent 
                bookmarkedItems={bookmarkedItems}
                toggleBookmark={toggleBookmark}
              />
            )}
            {activeTab === 'opportunities' && (
              <OpportunitiesContent 
                filters={filters} 
                bookmarkedItems={bookmarkedItems}
                toggleBookmark={toggleBookmark}
              />
            )}
            {activeTab === 'playbook' && <PlaybookContent />}
            {activeTab === 'events' && <EventsContent />}
            {activeTab === 'properties' && <PropertiesContent />}
            {activeTab === 'community' && <CommunityContent />}
          </div>
          
          <BottomNav activeTab={activeTab} setActiveTab={setActiveTab} />
        </>
      )}
    </div>
  );
};

export default App;