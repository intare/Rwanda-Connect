import musoniAvatar from '../assets/images/musoni.jpeg';

export const dummyUsers = [
  {
    id: 1,
    username: 'demo@rwandaconnect.com',
    password: 'demo123',
    fullName: 'Musoni Edwin',
    email: 'demo@rwandaconnect.com',
    location: 'Toronto, Canada',
    profileImage: musoniAvatar,
    interests: ['Technology', 'Investment', 'Business'],
    joinDate: 'Jan 2024',
    phone: '+1-416-555-0123',
    profession: 'Software Engineer'
  },
  // ... other users
];

export const availableInterests = [
  'Technology', 'Banking', 'Investment', 'Business', 'Real Estate', 
  'Education', 'Healthcare', 'Agriculture', 'Tourism', 'Manufacturing',
  // ... rest of interests
];

export const availableProfilePictures = [
  musoniAvatar,
  // ... other pictures could be added here
];