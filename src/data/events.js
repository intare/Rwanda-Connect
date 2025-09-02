export const dummyEvents = [
  {
    id: 1,
    title: "Rwanda Connect Toronto Networking Night",
    description: "Join fellow Rwandans in Toronto for an evening of networking, cultural exchange, and business opportunities. Connect with entrepreneurs, professionals, and community leaders.",
    type: "networking",
    category: "Professional",
    date: "2025-09-15",
    time: "18:00",
    endTime: "22:00",
    location: {
      name: "Four Points by Sheraton Toronto Airport",
      address: "6257 Airport Rd, Mississauga, ON L4V 1E4",
      city: "Toronto",
      country: "Canada"
    },
    organizer: {
      name: "Musoni Edwin",
      email: "musoni@rwandaconnect.com",
      phone: "+1-416-555-0123"
    },
    capacity: 150,
    registered: 67,
    price: 25,
    currency: "CAD",
    status: "upcoming",
    featured: true,
    tags: ["networking", "business", "toronto", "professional"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-20T10:00:00Z"
  },
  {
    id: 2,
    title: "Investment Opportunities in Rwanda - London Meet",
    description: "Explore lucrative investment opportunities in Rwanda's growing economy. Featuring guest speakers from RDB and successful diaspora investors.",
    type: "seminar",
    category: "Investment",
    date: "2025-09-22",
    time: "14:00",
    endTime: "17:00",
    location: {
      name: "The Shard - Level 31",
      address: "32 London Bridge St, London SE1 9SG",
      city: "London",
      country: "UK"
    },
    organizer: {
      name: "Sarah Uwimana",
      email: "sarah.uwimana@rwandaconnect.com",
      phone: "+44-20-7946-0958"
    },
    capacity: 80,
    registered: 34,
    price: 0,
    currency: "GBP",
    status: "upcoming",
    featured: true,
    tags: ["investment", "london", "economy", "business"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-18T09:30:00Z"
  },
  {
    id: 3,
    title: "Rwandan Students Scholarship Information Session",
    description: "Learn about available scholarships for Rwandan students, application processes, and success stories from scholarship recipients.",
    type: "workshop",
    category: "Education",
    date: "2025-09-10",
    time: "16:00",
    endTime: "18:00",
    location: {
      name: "University of Melbourne - Student Union",
      address: "Union House, Parkville VIC 3010",
      city: "Melbourne",
      country: "Australia"
    },
    organizer: {
      name: "Jean Baptiste Nzeyimana",
      email: "jb.nzeyimana@gmail.com",
      phone: "+61-3-8344-4000"
    },
    capacity: 60,
    registered: 42,
    price: 0,
    currency: "AUD",
    status: "upcoming",
    featured: false,
    tags: ["education", "scholarship", "students", "melbourne"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-15T14:20:00Z"
  },
  {
    id: 4,
    title: "Kigali Tech Week 2025 - Diaspora Virtual Participation",
    description: "Join Kigali Tech Week virtually from anywhere in the world. Network with local tech entrepreneurs and explore collaboration opportunities.",
    type: "conference",
    category: "Technology",
    date: "2025-10-05",
    time: "09:00",
    endTime: "17:00",
    location: {
      name: "Virtual Event",
      address: "Online Platform",
      city: "Virtual",
      country: "Global"
    },
    organizer: {
      name: "Rwanda Tech Community",
      email: "events@rwandatech.rw",
      phone: "+250-788-123-456"
    },
    capacity: 500,
    registered: 156,
    price: 15,
    currency: "USD",
    status: "upcoming",
    featured: true,
    tags: ["technology", "virtual", "kigali", "innovation"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-25T11:15:00Z"
  },
  {
    id: 5,
    title: "Cultural Night: Celebrating Rwandan Heritage - NYC",
    description: "An evening celebrating Rwandan culture with traditional music, dance, and cuisine. Perfect for families and cultural enthusiasts.",
    type: "cultural",
    category: "Culture",
    date: "2025-09-28",
    time: "19:00",
    endTime: "23:00",
    location: {
      name: "Brooklyn Museum",
      address: "200 Eastern Pkwy, Brooklyn, NY 11238",
      city: "New York",
      country: "USA"
    },
    organizer: {
      name: "Rwandan Community of NY",
      email: "info@rwandanyny.org",
      phone: "+1-718-555-0199"
    },
    capacity: 200,
    registered: 89,
    price: 20,
    currency: "USD",
    status: "upcoming",
    featured: false,
    tags: ["culture", "music", "dance", "nyc", "family"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-22T16:45:00Z"
  },
  {
    id: 6,
    title: "Business Mentorship Program Launch - Boston",
    description: "Launch of our new mentorship program connecting experienced Rwandan business leaders with emerging entrepreneurs.",
    type: "program",
    category: "Professional",
    date: "2025-08-30",
    time: "18:30",
    endTime: "21:00",
    location: {
      name: "Boston Convention Center",
      address: "415 Summer St, Boston, MA 02210",
      city: "Boston",
      country: "USA"
    },
    organizer: {
      name: "Diane Karusisi",
      email: "diane.k@rwandaconnect.com",
      phone: "+1-617-555-0145"
    },
    capacity: 100,
    registered: 100,
    price: 30,
    currency: "USD",
    status: "completed",
    featured: false,
    tags: ["mentorship", "business", "boston", "entrepreneurship"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-01T12:00:00Z"
  },
  {
    id: 7,
    title: "Healthcare Professionals Meetup - Dubai",
    description: "Monthly meetup for Rwandan healthcare professionals working in the UAE. Share experiences and explore opportunities.",
    type: "meetup",
    category: "Professional",
    date: "2025-09-18",
    time: "17:00",
    endTime: "19:30",
    location: {
      name: "Emirates Golf Club",
      address: "Sheikh Zayed Rd, Dubai, UAE",
      city: "Dubai",
      country: "UAE"
    },
    organizer: {
      name: "Dr. Alice Mukamana",
      email: "alice.mukamana@healthae.ae",
      phone: "+971-4-555-0123"
    },
    capacity: 40,
    registered: 28,
    price: 0,
    currency: "AED",
    status: "upcoming",
    featured: false,
    tags: ["healthcare", "professional", "dubai", "networking"],
    image: "/api/placeholder/400/200",
    createdAt: "2025-08-28T08:30:00Z"
  }
];

export const eventCategories = [
  "Professional",
  "Investment",
  "Education", 
  "Technology",
  "Culture",
  "Healthcare",
  "Sports",
  "Social",
  "Business",
  "Career"
];

export const eventTypes = [
  "networking",
  "seminar", 
  "workshop",
  "conference",
  "cultural",
  "program",
  "meetup",
  "webinar",
  "social",
  "fundraiser"
];

export const popularLocations = [
  "Toronto, Canada",
  "London, UK", 
  "New York, USA",
  "Boston, USA",
  "Melbourne, Australia",
  "Dubai, UAE",
  "Brussels, Belgium",
  "Paris, France",
  "Virtual/Online",
  "Kigali, Rwanda"
];

// Helper functions
export const getEventsByStatus = (status) => {
  return dummyEvents.filter(event => event.status === status);
};

export const getEventsByCategory = (category) => {
  return dummyEvents.filter(event => event.category === category);
};

export const getFeaturedEvents = () => {
  return dummyEvents.filter(event => event.featured);
};

export const getUpcomingEvents = () => {
  const now = new Date();
  return dummyEvents.filter(event => {
    const eventDate = new Date(event.date + 'T' + event.time);
    return eventDate > now && event.status === 'upcoming';
  }).sort((a, b) => new Date(a.date) - new Date(b.date));
};

export const searchEvents = (query) => {
  const lowercaseQuery = query.toLowerCase();
  return dummyEvents.filter(event => 
    event.title.toLowerCase().includes(lowercaseQuery) ||
    event.description.toLowerCase().includes(lowercaseQuery) ||
    event.tags.some(tag => tag.toLowerCase().includes(lowercaseQuery)) ||
    event.location.city.toLowerCase().includes(lowercaseQuery)
  );
};