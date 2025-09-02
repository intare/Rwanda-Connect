import React, { useState } from 'react';
import { ArrowLeft, CreditCard, Smartphone, Shield, Lock, Check, ArrowRight } from 'lucide-react';

const PaymentMethodScreen = ({ selectedPlan, onBack, onComplete, auth }) => {
  const [selectedMethod, setSelectedMethod] = useState('card');
  const [isProcessing, setIsProcessing] = useState(false);
  const [formData, setFormData] = useState({
    // Card details
    cardNumber: '',
    expiryDate: '',
    cvv: '',
    cardholderName: '',
    // MoMo details
    momoNumber: '',
    momoProvider: 'MTN',
    // PayPal details
    paypalEmail: ''
  });

  const paymentMethods = [
    {
      id: 'card',
      name: 'Credit/Debit Card',
      description: 'Visa, Mastercard, American Express',
      icon: <CreditCard className="w-6 h-6" />,
      popular: true
    },
    {
      id: 'momo',
      name: 'Mobile Money',
      description: 'MTN MoMo, Airtel Money, Tigo Cash',
      icon: <Smartphone className="w-6 h-6" />,
      popular: false
    },
    {
      id: 'paypal',
      name: 'PayPal',
      description: 'Pay with your PayPal account',
      icon: (
        <svg className="w-6 h-6" viewBox="0 0 24 24" fill="currentColor">
          <path d="M7.076 21.337H2.47a.641.641 0 0 1-.633-.74L4.944.901C5.026.382 5.474 0 5.998 0h7.46c2.57 0 4.578.543 5.69 1.81 1.01 1.15 1.304 2.42 1.012 4.287-.023.143-.047.288-.077.437-.983 5.05-4.349 6.797-8.647 6.797h-2.19c-.524 0-.968.382-1.05.9l-1.12 7.106zm14.146-14.42a3.35 3.35 0 0 0-.607-.393c-.36-.18-.756-.295-1.193-.345l-.299.058c-.185.04-.357.097-.518.17l-.296.12-.257.137c-.183.105-.353.225-.509.36l-.27.26c-.148.155-.285.32-.41.495l-.22.32c-.1.155-.19.315-.27.48l-.14.3c-.07.155-.13.315-.18.48l-.09.33c-.04.175-.07.355-.09.54l-.03.39v.12l.015.27c.015.18.045.36.09.54l.09.33c.05.165.11.325.18.48l.14.3c.08.165.17.325.27.48l.22.32c.125.175.262.34.41.495l.27.26c.156.135.326.255.509.36l.257.137.296.12c.161.073.333.13.518.17l.299.058c.437-.05.833-.165 1.193-.345.218-.108.424-.238.607-.393.36-.3.646-.66.848-1.068.203-.408.323-.858.358-1.34.035-.482-.03-.965-.193-1.433-.163-.468-.413-.904-.742-1.295z"/>
        </svg>
      ),
      popular: false
    }
  ];

  const handleInputChange = (field, value) => {
    setFormData(prev => ({
      ...prev,
      [field]: value
    }));
  };

  const formatCardNumber = (value) => {
    const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    const matches = v.match(/\d{4,16}/g);
    const match = matches && matches[0] || '';
    const parts = [];
    for (let i = 0, len = match.length; i < len; i += 4) {
      parts.push(match.substring(i, i + 4));
    }
    if (parts.length) {
      return parts.join(' ');
    } else {
      return v;
    }
  };

  const formatExpiryDate = (value) => {
    const v = value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    if (v.length >= 2) {
      return v.substring(0, 2) + '/' + v.substring(2, 4);
    }
    return v;
  };

  const handleCardNumberChange = (value) => {
    const formatted = formatCardNumber(value);
    if (formatted.length <= 19) { // 16 digits + 3 spaces
      handleInputChange('cardNumber', formatted);
    }
  };

  const handleExpiryChange = (value) => {
    const formatted = formatExpiryDate(value);
    if (formatted.length <= 5) { // MM/YY
      handleInputChange('expiryDate', formatted);
    }
  };

  const handlePayment = async () => {
    setIsProcessing(true);
    
    // Simulate payment processing
    setTimeout(() => {
      // Update user with subscription info
      auth.updateProfile({
        ...auth.currentUser,
        subscription: {
          plan: selectedPlan.id,
          planName: selectedPlan.name,
          price: selectedPlan.price,
          startDate: new Date().toISOString(),
          status: 'active',
          paymentMethod: selectedMethod,
          nextBillingDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString()
        }
      });

      setIsProcessing(false);
      onComplete();
    }, 3000);
  };

  const isFormValid = () => {
    if (selectedMethod === 'card') {
      return (formData.cardNumber.replace(/\s/g, '').length >= 13) && 
             (formData.expiryDate.length === 5) && 
             (formData.cvv.length >= 3) && 
             (formData.cardholderName.length > 0);
    } else if (selectedMethod === 'momo') {
      return formData.momoNumber.length >= 10;
    } else if (selectedMethod === 'paypal') {
      return formData.paypalEmail.includes('@');
    }
    return false;
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
        <div className="px-6 pt-12 pb-6">
          <div className="flex items-center mb-6">
            <button
              onClick={onBack}
              className="mr-4 p-2 rounded-full bg-gray-900 hover:bg-gray-700 transition-colors"
            >
              <ArrowLeft className="w-5 h-5 text-white" />
            </button>
            <h1 className="text-2xl font-bold text-white">Payment Method</h1>
          </div>
          
          {/* Plan Summary */}
          <div className="bg-white rounded-2xl p-6 mb-6">
            <div className="flex justify-between items-start mb-4">
              <div>
                <h3 className="text-lg font-semibold text-gray-900">{selectedPlan.name}</h3>
                <p className="text-gray-600">{selectedPlan.description}</p>
              </div>
              <div className="text-right">
                <span className="text-2xl font-bold text-gray-900">${selectedPlan.price}</span>
                <span className="text-gray-600">/{selectedPlan.period}</span>
              </div>
            </div>
            {selectedPlan.originalPrice && (
              <div className="flex items-center">
                <span className="text-sm text-gray-400 line-through mr-2">
                  ${selectedPlan.originalPrice}
                </span>
                <span className="bg-black text-white px-2 py-1 rounded-full text-xs font-medium">
                  Save ${selectedPlan.savings}
                </span>
              </div>
            )}
          </div>
        </div>

        {/* Payment Methods */}
        <div className="px-6 mb-6">
          <h2 className="text-lg font-semibold text-white mb-4">Choose Payment Method</h2>
          <div className="space-y-3">
            {paymentMethods.map((method) => (
              <button
                key={method.id}
                onClick={() => setSelectedMethod(method.id)}
                className={`w-full p-4 rounded-xl border-2 transition-all duration-200 ${
                  selectedMethod === method.id
                    ? 'bg-white border-white text-black'
                    : 'bg-gray-900/50 border-gray-600 text-white hover:border-gray-400'
                }`}
              >
                <div className="flex items-center">
                  <div className={`mr-4 ${selectedMethod === method.id ? 'text-black' : 'text-gray-300'}`}>
                    {method.icon}
                  </div>
                  <div className="flex-1 text-left">
                    <div className="flex items-center">
                      <h3 className="font-semibold">{method.name}</h3>
                      {method.popular && (
                        <span className="ml-2 bg-black text-white px-2 py-0.5 rounded-full text-xs">
                          Popular
                        </span>
                      )}
                    </div>
                    <p className={`text-sm ${selectedMethod === method.id ? 'text-gray-600' : 'text-gray-400'}`}>
                      {method.description}
                    </p>
                  </div>
                  <div className={`w-6 h-6 rounded-full border-2 flex items-center justify-center ${
                    selectedMethod === method.id
                      ? 'border-black bg-black'
                      : 'border-gray-400'
                  }`}>
                    {selectedMethod === method.id && (
                      <Check className="w-4 h-4 text-white" />
                    )}
                  </div>
                </div>
              </button>
            ))}
          </div>
        </div>

        {/* Payment Form */}
        <div className="px-6 mb-6">
          <div className="bg-white rounded-2xl p-6">
            {selectedMethod === 'card' && (
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Card Number
                  </label>
                  <input
                    type="text"
                    value={formData.cardNumber}
                    onChange={(e) => handleCardNumberChange(e.target.value)}
                    placeholder="1234 5678 9012 3456"
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  />
                </div>
                <div className="grid grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      Expiry Date
                    </label>
                    <input
                      type="text"
                      value={formData.expiryDate}
                      onChange={(e) => handleExpiryChange(e.target.value)}
                      placeholder="MM/YY"
                      className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">
                      CVV
                    </label>
                    <input
                      type="text"
                      value={formData.cvv}
                      onChange={(e) => handleInputChange('cvv', e.target.value.replace(/\D/g, '').substring(0, 4))}
                      placeholder="123"
                      className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                    />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Cardholder Name
                  </label>
                  <input
                    type="text"
                    value={formData.cardholderName}
                    onChange={(e) => handleInputChange('cardholderName', e.target.value)}
                    placeholder="John Doe"
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  />
                </div>
              </div>
            )}

            {selectedMethod === 'momo' && (
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Mobile Money Provider
                  </label>
                  <select
                    value={formData.momoProvider}
                    onChange={(e) => handleInputChange('momoProvider', e.target.value)}
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  >
                    <option value="MTN">MTN MoMo</option>
                    <option value="Airtel">Airtel Money</option>
                    <option value="Tigo">Tigo Cash</option>
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Phone Number
                  </label>
                  <input
                    type="tel"
                    value={formData.momoNumber}
                    onChange={(e) => handleInputChange('momoNumber', e.target.value.replace(/\D/g, ''))}
                    placeholder="0781234567"
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  />
                </div>
                <div className="bg-gray-50 p-4 rounded-lg">
                  <div className="flex items-start">
                    <Smartphone className="w-5 h-5 text-gray-600 mt-0.5 mr-3" />
                    <div>
                      <p className="text-sm font-medium text-gray-900">Mobile Money Payment</p>
                      <p className="text-xs text-gray-600 mt-1">
                        You'll receive a payment request on your phone. Please approve it to complete the payment.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {selectedMethod === 'paypal' && (
              <div className="space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    PayPal Email
                  </label>
                  <input
                    type="email"
                    value={formData.paypalEmail}
                    onChange={(e) => handleInputChange('paypalEmail', e.target.value)}
                    placeholder="your@email.com"
                    className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-black focus:border-black"
                  />
                </div>
                <div className="bg-blue-50 p-4 rounded-lg">
                  <div className="flex items-start">
                    <Shield className="w-5 h-5 text-blue-600 mt-0.5 mr-3" />
                    <div>
                      <p className="text-sm font-medium text-blue-900">PayPal Payment</p>
                      <p className="text-xs text-blue-700 mt-1">
                        You'll be redirected to PayPal to complete your payment securely.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Security Notice */}
        <div className="px-6 mb-6">
          <div className="flex items-center justify-center text-gray-400 text-sm">
            <Lock className="w-4 h-4 mr-2" />
            <span>Your payment information is encrypted and secure</span>
          </div>
        </div>

        {/* Payment Button */}
        <div className="px-6 pb-8">
          <button
            onClick={handlePayment}
            disabled={!isFormValid() || isProcessing}
            className="w-full bg-black hover:bg-gray-800 text-white py-4 px-6 rounded-2xl font-semibold text-lg transition-all duration-300 transform hover:scale-105 disabled:opacity-50 disabled:cursor-not-allowed disabled:transform-none"
          >
            {isProcessing ? (
              <div className="flex items-center justify-center">
                <div className="animate-spin rounded-full h-6 w-6 border-b-2 border-white mr-3"></div>
                Processing payment...
              </div>
            ) : (
              <div className="flex items-center justify-center">
                Complete Payment - ${selectedPlan.price}
                <ArrowRight className="w-5 h-5 ml-2" />
              </div>
            )}
          </button>
        </div>
      </div>
    </div>
  );
};

export default PaymentMethodScreen;