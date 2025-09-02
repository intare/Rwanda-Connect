import React, { useState } from 'react';
import { Check, Crown, Zap, Star, Clock, Shield, ArrowRight } from 'lucide-react';

const SubscriptionScreen = ({ auth, onComplete, onSkip, onPlanSelected }) => {
  const [selectedPlan, setSelectedPlan] = useState('trial');
  const [isProcessing, setIsProcessing] = useState(false);
  const [showAllFeatures, setShowAllFeatures] = useState(false);

  const plans = [
    {
      id: 'trial',
      name: 'Start Free',
      price: 0,
      period: '30 days',
      description: 'Try everything risk-free',
      tagline: 'Most Popular Choice',
      features: [
        'Full access to all opportunities',
        'Premium community features',
        'Unlimited applications',
        'Advanced profile visibility',
        'Priority customer support'
      ],
      buttonText: 'Start 30-Day Free Trial',
      buttonStyle: 'bg-black hover:bg-gray-800 text-white shadow-lg transform hover:scale-105',
      popular: true,
      gradient: 'bg-white',
      border: 'border-2 border-black shadow-xl',
      icon: <Star className="w-6 h-6 text-black" />
    },
    {
      id: 'monthly',
      name: 'Pro Monthly',
      price: 10,
      period: 'month',
      description: 'Perfect for active networking',
      features: [
        'Everything in Free Trial',
        'Advanced analytics dashboard',
        'Personalized opportunity matching',
        'Direct mentor connections',
        'Weekly career insights'
      ],
      buttonText: 'Continue with Monthly',
      buttonStyle: 'bg-gray-900 hover:bg-black text-white shadow-md transform hover:scale-105',
      popular: false,
      gradient: 'bg-gray-50',
      border: 'border border-gray-300 hover:border-gray-400',
      icon: <Zap className="w-6 h-6 text-gray-700" />
    },
    {
      id: 'yearly',
      name: 'Pro Yearly',
      price: 96,
      period: 'year',
      originalPrice: 120,
      savings: 24,
      description: 'Best value for serious professionals',
      badge: 'Save 20%',
      features: [
        'Everything in Pro Monthly',
        'Personal success manager',
        'Exclusive investor connections',
        'Annual career strategy session',
        'Early access to new features',
        'VIP networking events'
      ],
      buttonText: 'Get Best Value',
      buttonStyle: 'bg-black hover:bg-gray-800 text-white shadow-lg transform hover:scale-105',
      popular: false,
      gradient: 'bg-gray-100',
      border: 'border border-gray-300 hover:border-gray-400',
      icon: <Crown className="w-6 h-6 text-gray-700" />
    }
  ];

  const handleSubscribe = async (planId) => {
    const selectedPlanData = plans.find(p => p.id === planId);
    
    if (selectedPlanData.price === 0) {
      // Free trial - no payment needed
      setIsProcessing(true);
      setTimeout(() => {
        auth.updateProfile({
          ...auth.currentUser,
          subscription: {
            plan: planId,
            planName: selectedPlanData.name,
            price: selectedPlanData.price,
            startDate: new Date().toISOString(),
            status: 'active'
          }
        });
        setIsProcessing(false);
        onComplete();
      }, 1500);
    } else {
      // Paid plan - go to payment method screen
      onPlanSelected(selectedPlanData);
    }
  };

  const handleSkipForNow = () => {
    // Set user as free tier
    auth.updateProfile({
      ...auth.currentUser,
      subscription: {
        plan: 'free',
        planName: 'Free Tier',
        price: 0,
        startDate: new Date().toISOString(),
        status: 'active'
      }
    });
    onSkip();
  };

  return (
    <div className="min-h-screen bg-black relative overflow-hidden">
      {/* Background decoration */}
      <div className="absolute inset-0 opacity-10">
        <div className="absolute top-0 left-0 w-full h-full bg-repeat" 
             style={{
               backgroundImage: "radial-gradient(circle, rgba(255, 255, 255, 0.1) 2px, transparent 2px)",
               backgroundSize: "60px 60px"
             }}>
        </div>
      </div>
      
      <div className="relative z-10 max-w-sm mx-auto min-h-screen">
        {/* Header */}
        <div className="px-6 pt-12 pb-8 text-center">
          <div className="mb-6">
            <div className="w-20 h-20 mx-auto bg-white rounded-2xl flex items-center justify-center shadow-2xl">
              <Crown className="w-10 h-10 text-black" />
            </div>
          </div>
          <h1 className="text-3xl font-bold text-white mb-3">
            Welcome to<br />Rwanda Connect
          </h1>
          <p className="text-gray-300 text-lg leading-relaxed">
            Choose your plan and unlock opportunities back home
          </p>
        </div>

        {/* Plan Toggle */}
        <div className="px-6 mb-8">
          <div className="bg-gray-900/50 backdrop-blur-xl rounded-2xl p-1 border border-gray-600">
            <div className="grid grid-cols-3 gap-1">
              {plans.map((plan) => (
                <button
                  key={plan.id}
                  onClick={() => setSelectedPlan(plan.id)}
                  className={`relative py-3 px-2 rounded-xl text-sm font-medium transition-all duration-300 ${
                    selectedPlan === plan.id
                      ? 'bg-white text-black shadow-lg'
                      : 'text-gray-300 hover:text-white'
                  }`}
                >
                  {plan.badge && (
                    <div className="absolute -top-2 -right-1 bg-black text-white text-xs px-2 py-0.5 rounded-full">
                      {plan.badge}
                    </div>
                  )}
                  <div className="flex flex-col items-center">
                    <div className={`mb-1 transition-colors ${selectedPlan === plan.id ? 'text-black' : 'text-gray-300'}`}>
                      {plan.icon}
                    </div>
                    <span className="text-xs">{plan.name}</span>
                  </div>
                </button>
              ))}
            </div>
          </div>
        </div>

        {/* Selected Plan Card */}
        <div className="px-6 mb-8">
          {plans.filter(plan => plan.id === selectedPlan).map((plan) => (
            <div
              key={plan.id}
              className={`${plan.gradient} backdrop-blur-xl rounded-3xl p-8 shadow-2xl ${plan.border}`}
            >
              {plan.popular && (
                <div className="flex items-center justify-center mb-6">
                  <div className="bg-black text-white px-4 py-2 rounded-full text-sm font-medium flex items-center">
                    <Star className="w-4 h-4 mr-2" />
                    {plan.tagline}
                  </div>
                </div>
              )}

              {/* Pricing */}
              <div className="text-center mb-8">
                <h2 className="text-2xl font-bold text-gray-900 mb-2">{plan.name}</h2>
                <p className="text-gray-600 mb-6">{plan.description}</p>
                
                <div className="mb-6">
                  {plan.originalPrice && (
                    <div className="text-center mb-2">
                      <span className="text-lg text-gray-400 line-through">
                        ${plan.originalPrice}
                      </span>
                      <span className="ml-2 bg-black text-white px-3 py-1 rounded-full text-sm font-medium">
                        Save ${plan.savings}
                      </span>
                    </div>
                  )}
                  <div className="flex items-end justify-center">
                    <span className="text-5xl font-bold text-gray-900">
                      ${plan.price}
                    </span>
                    {plan.price > 0 && (
                      <span className="text-gray-500 mb-2 ml-2">/{plan.period}</span>
                    )}
                  </div>
                </div>
              </div>

              {/* Features */}
              <div className="space-y-4 mb-8">
                {plan.features.slice(0, showAllFeatures ? undefined : 3).map((feature, index) => (
                  <div key={index} className="flex items-start">
                    <div className="w-6 h-6 bg-black rounded-full flex items-center justify-center mt-0.5 mr-3 flex-shrink-0">
                      <Check className="w-4 h-4 text-white" />
                    </div>
                    <span className="text-gray-700 leading-relaxed">{feature}</span>
                  </div>
                ))}
                
                {plan.features.length > 3 && (
                  <button
                    onClick={() => setShowAllFeatures(!showAllFeatures)}
                    className="flex items-center text-black hover:text-gray-700 font-medium text-sm"
                  >
                    {showAllFeatures ? 'Show less' : `View ${plan.features.length - 3} more features`}
                    <ArrowRight className={`w-4 h-4 ml-1 transition-transform ${showAllFeatures ? 'rotate-90' : ''}`} />
                  </button>
                )}
              </div>

              {/* CTA Button */}
              <button
                onClick={() => handleSubscribe(plan.id)}
                disabled={isProcessing}
                className={`w-full py-4 px-6 rounded-2xl font-semibold text-lg transition-all duration-300 ${plan.buttonStyle} disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none`}
              >
                {isProcessing ? (
                  <div className="flex items-center justify-center">
                    <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-white mr-3"></div>
                    Setting up your account...
                  </div>
                ) : (
                  <div className="flex items-center justify-center">
                    {plan.buttonText}
                    <ArrowRight className="w-5 h-5 ml-2" />
                  </div>
                )}
              </button>
            </div>
          ))}
        </div>

        {/* Trust Indicators */}
        <div className="px-6 mb-8">
          <div className="bg-gray-900/50 backdrop-blur-xl rounded-2xl p-6 border border-gray-600">
            <div className="grid grid-cols-3 gap-4 text-center">
              <div className="text-gray-300">
                <Shield className="w-8 h-8 mx-auto mb-2 text-white" />
                <p className="text-xs">Secure<br />Payment</p>
              </div>
              <div className="text-gray-300">
                <Clock className="w-8 h-8 mx-auto mb-2 text-white" />
                <p className="text-xs">Cancel<br />Anytime</p>
              </div>
              <div className="text-gray-300">
                <Star className="w-8 h-8 mx-auto mb-2 text-white" />
                <p className="text-xs">Money-back<br />Guarantee</p>
              </div>
            </div>
          </div>
        </div>

        {/* Skip Option */}
        <div className="px-6 pb-8 text-center">
          <button
            onClick={handleSkipForNow}
            className="text-gray-400 hover:text-white text-sm underline"
          >
            Continue with limited access
          </button>
        </div>
      </div>
    </div>
  );
};

export default SubscriptionScreen;