import { useState } from 'react';
import { dummyUsers } from '../data/dummyUsers';

export const useAuth = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [currentUser, setCurrentUser] = useState(null);
  const [authError, setAuthError] = useState('');

  const handleLogin = (username, password) => {
    setAuthError('');
    
    const user = dummyUsers.find(u => 
      u.username === username && u.password === password
    );
    
    if (user) {
      setCurrentUser(user);
      setIsAuthenticated(true);
      return true;
    } else {
      setAuthError('Invalid username or password');
      return false;
    }
  };

  const handleLogout = () => {
    setCurrentUser(null);
    setIsAuthenticated(false);
  };

  return {
    isAuthenticated,
    currentUser,
    authError,
    handleLogin,
    handleLogout,
    setCurrentUser
  };
};