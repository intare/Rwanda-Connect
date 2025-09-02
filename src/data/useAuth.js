import { useState } from 'react';
import { dummyUsers } from '../data/dummyUsers';
import musoniAvatar from '../assets/images/musoni.jpeg';

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

  const handleRegister = (formData) => {
    setAuthError('');
    
    if (formData.password !== formData.confirmPassword) {
      setAuthError('Passwords do not match');
      return false;
    }
    
    if (formData.fullName && formData.email && formData.password && formData.location) {
      const newUser = {
        id: dummyUsers.length + 1,
        username: formData.email,
        password: formData.password,
        fullName: formData.fullName,
        email: formData.email,
        location: formData.location,
        profileImage: musoniAvatar,
        interests: formData.interests || [],
        joinDate: 'Sep 2025',
        phone: '',
        profession: ''
      };
      
      setCurrentUser(newUser);
      setIsAuthenticated(true);
      return true;
    } else {
      setAuthError('Please fill in all required fields');
      return false;
    }
  };

  const handleLogout = () => {
    setCurrentUser(null);
    setIsAuthenticated(false);
  };

  const updateProfile = (updatedData) => {
    const updatedUser = {
      ...currentUser,
      ...updatedData
    };
    setCurrentUser(updatedUser);
  };

  return {
    isAuthenticated,
    currentUser,
    authError,
    handleLogin,
    handleRegister,
    handleLogout,
    updateProfile,
    setCurrentUser,
    setAuthError
  };
};