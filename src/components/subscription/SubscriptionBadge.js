import React from 'react';
import { Crown, Clock, Star } from 'lucide-react';
import { formatSubscriptionStatus, getSubscriptionStatus, getRemainingTrialDays } from '../../utils/subscriptionUtils';

const SubscriptionBadge = ({ user, showDetails = false }) => {
  if (!user || !user.subscription) {
    return (
      <div className="flex items-center px-2 py-1 bg-gray-100 rounded-md text-xs text-gray-600">
        <span>Free</span>
      </div>
    );
  }

  const status = getSubscriptionStatus(user);
  const isExpired = status === 'expired';
  const isTrial = user.subscription.plan === 'trial';
  const isPremium = ['monthly', 'quarterly', 'yearly'].includes(user.subscription.plan);
  
  if (isExpired) {
    return (
      <div className="flex items-center px-2 py-1 bg-red-100 rounded-md text-xs text-red-700">
        <Clock className="w-3 h-3 mr-1" />
        <span>Expired</span>
      </div>
    );
  }

  if (isTrial) {
    const remainingDays = getRemainingTrialDays(user);
    return (
      <div className="flex items-center px-2 py-1 bg-blue-100 rounded-md text-xs text-blue-700">
        <Star className="w-3 h-3 mr-1" />
        <span>Trial ({remainingDays}d)</span>
      </div>
    );
  }

  if (isPremium) {
    return (
      <div className="flex items-center px-2 py-1 bg-yellow-100 rounded-md text-xs text-yellow-700">
        <Crown className="w-3 h-3 mr-1" />
        <span>{showDetails ? user.subscription.planName : 'Premium'}</span>
      </div>
    );
  }

  return (
    <div className="flex items-center px-2 py-1 bg-gray-100 rounded-md text-xs text-gray-600">
      <span>Free</span>
    </div>
  );
};

export default SubscriptionBadge;