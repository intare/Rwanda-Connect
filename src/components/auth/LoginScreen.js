import React, { useState } from 'react';

const LoginScreen = ({ auth }) => {
  const [showLogin, setShowLogin] = useState(true);
  const [loginForm, setLoginForm] = useState({ username: '', password: '' });
  const [registerForm, setRegisterForm] = useState({ 
    fullName: '', 
    email: '', 
    password: '', 
    confirmPassword: '',
    location: '',
    interests: []
  });

  const handleLogin = (e) => {
    e.preventDefault();
    auth.handleLogin(loginForm.username, loginForm.password);
    if (auth.isAuthenticated) {
      setLoginForm({ username: '', password: '' });
    }
  };

  const handleRegister = (e) => {
    e.preventDefault();
    const success = auth.handleRegister(registerForm);
    if (success) {
      setRegisterForm({ fullName: '', email: '', password: '', confirmPassword: '', location: '', interests: [] });
    }
  };

  return (
    <div className="min-h-screen bg-black flex items-center justify-center p-4">
      <div className="bg-white rounded-lg border border-gray-300 shadow-lg w-full max-w-sm p-6">
        <div className="text-center mb-6">
          <div className="flex justify-center mb-4">
            <img 
              src={process.env.PUBLIC_URL + "/logo.jpeg"} 
              alt="Rwanda Connect Logo" 
              className="w-42 h-42 object-contain"
              onError={(e) => {
                e.target.style.display = 'none';
              }}
            />
          </div>
          <p className="text-gray-600">Connect with opportunities back home</p>
        </div>

        <div className="flex mb-6 bg-gray-100 rounded-lg p-1">
          <button
            onClick={() => setShowLogin(true)}
            className={`flex-1 py-2 px-4 rounded-md text-sm font-medium transition-colors ${
              showLogin 
                ? 'bg-black text-white shadow-sm' 
                : 'text-gray-600 hover:text-black'
            }`}
          >
            Login
          </button>
          <button
            onClick={() => setShowLogin(false)}
            className={`flex-1 py-2 px-4 rounded-md text-sm font-medium transition-colors ${
              !showLogin 
                ? 'bg-black text-white shadow-sm' 
                : 'text-gray-600 hover:text-black'
            }`}
          >
            Register
          </button>
        </div>

        {auth.authError && (
          <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-md mb-4 text-sm">
            {auth.authError}
          </div>
        )}

        {showLogin ? (
          <form onSubmit={handleLogin} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Username/Email
              </label>
              <input
                type="text"
                value={loginForm.username}
                onChange={(e) => setLoginForm({...loginForm, username: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="demo@rwandaconnect.com"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Password
              </label>
              <input
                type="password"
                value={loginForm.password}
                onChange={(e) => setLoginForm({...loginForm, password: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="demo123"
                required
              />
            </div>
            <button
              type="submit"
              className="w-full bg-black text-white py-3 px-4 rounded-lg font-medium hover:bg-gray-800 transition-colors"
            >
              Sign In
            </button>
          </form>
        ) : (
          <form onSubmit={handleRegister} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Full Name *
              </label>
              <input
                type="text"
                value={registerForm.fullName}
                onChange={(e) => setRegisterForm({...registerForm, fullName: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="Jean Claude Nkurunziza"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Email *
              </label>
              <input
                type="email"
                value={registerForm.email}
                onChange={(e) => setRegisterForm({...registerForm, email: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="your.email@example.com"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Current Location *
              </label>
              <input
                type="text"
                value={registerForm.location}
                onChange={(e) => setRegisterForm({...registerForm, location: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="Toronto, Canada"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Password *
              </label>
              <input
                type="password"
                value={registerForm.password}
                onChange={(e) => setRegisterForm({...registerForm, password: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="Create a password"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-black mb-1">
                Confirm Password *
              </label>
              <input
                type="password"
                value={registerForm.confirmPassword}
                onChange={(e) => setRegisterForm({...registerForm, confirmPassword: e.target.value})}
                className="w-full p-3 border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
                placeholder="Confirm your password"
                required
              />
            </div>
            <button
              type="submit"
              className="w-full bg-black text-white py-3 px-4 rounded-lg font-medium hover:bg-gray-800 transition-colors"
            >
              Create Account
            </button>
          </form>
        )}

        <div className="mt-6 pt-6 border-t border-black">
          <div className="text-center text-sm text-gray-600">
            <p className="mb-2">Demo Credentials:</p>
            <p className="text-xs bg-gray-50 p-2 rounded">
              <strong>Email:</strong> demo@rwandaconnect.com<br />
              <strong>Password:</strong> demo123
            </p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default LoginScreen;