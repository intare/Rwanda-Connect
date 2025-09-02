// Subscription utility functions

export const subscriptionPlans = {
  free: {
    name: 'Free Tier',
    price: 0,
    features: ['Limited access', 'Basic community'],
    limits: { applications: 5, connections: 10 }
  },
  trial: {
    name: 'Free Trial',
    price: 0,
    duration: 30, // days
    features: ['Full access for 1 month', 'All premium features'],
    limits: { applications: 100, connections: 100 }
  },
  monthly: {
    name: 'Monthly Plan',
    price: 10,
    features: ['Unlimited applications', 'Premium community', 'Priority support'],
    limits: { applications: -1, connections: -1 } // -1 means unlimited
  },
  quarterly: {
    name: 'Quarterly Plan',
    price: 27,
    originalPrice: 30,
    savings: 3,
    features: ['Everything in Monthly', '10% discount', 'Strategy sessions'],
    limits: { applications: -1, connections: -1 }
  },
  yearly: {
    name: 'Yearly Plan',
    price: 96,
    originalPrice: 120,
    savings: 24,
    features: ['Everything in Quarterly', '20% discount', 'Personal manager'],
    limits: { applications: -1, connections: -1 }
  }
};

export const getSubscriptionStatus = (user) => {
  if (!user || !user.subscription) {
    return 'none';
  }
  
  const subscription = user.subscription;
  const startDate = new Date(subscription.startDate);
  const now = new Date();
  
  // Check if it's a trial
  if (subscription.plan === 'trial') {
    const trialEndDate = new Date(startDate.getTime() + (30 * 24 * 60 * 60 * 1000));
    if (now > trialEndDate) {
      return 'expired';
    }
  }
  
  return subscription.status || 'active';
};

export const canUserAccess = (user, feature) => {
  const status = getSubscriptionStatus(user);
  
  if (status === 'none' || status === 'expired') {
    return false;
  }
  
  if (!user.subscription) {
    return false;
  }
  
  const plan = subscriptionPlans[user.subscription.plan];
  
  if (!plan) {
    return false;
  }
  
  // Check specific feature limits
  if (feature === 'unlimited_applications') {
    return plan.limits.applications === -1;
  }
  
  if (feature === 'premium_community') {
    return user.subscription.plan !== 'free';
  }
  
  if (feature === 'priority_support') {
    return ['monthly', 'quarterly', 'yearly'].includes(user.subscription.plan);
  }
  
  return true;
};

export const getRemainingTrialDays = (user) => {
  if (!user || !user.subscription || user.subscription.plan !== 'trial') {
    return 0;
  }
  
  const startDate = new Date(user.subscription.startDate);
  const now = new Date();
  const trialEndDate = new Date(startDate.getTime() + (30 * 24 * 60 * 60 * 1000));
  
  const remainingTime = trialEndDate.getTime() - now.getTime();
  const remainingDays = Math.ceil(remainingTime / (24 * 60 * 60 * 1000));
  
  return Math.max(0, remainingDays);
};

export const formatSubscriptionStatus = (user) => {
  if (!user || !user.subscription) {
    return 'No subscription';
  }
  
  const status = getSubscriptionStatus(user);
  const plan = subscriptionPlans[user.subscription.plan];
  
  if (status === 'expired') {
    return 'Subscription expired';
  }
  
  if (user.subscription.plan === 'trial') {
    const remainingDays = getRemainingTrialDays(user);
    return `Free trial - ${remainingDays} days remaining`;
  }
  
  return `${plan?.name || 'Unknown Plan'} - Active`;
};