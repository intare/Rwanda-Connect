export const dummyProperties = [
  {
    id: 1,
    title: "Modern 3-Bedroom Villa in Nyarutarama",
    description: "Stunning contemporary villa in Kigali's premier neighborhood. Features spacious living areas, modern kitchen, master suite with walk-in closet, landscaped garden, and 24/7 security.",
    type: "villa",
    category: "residential",
    status: "for_sale",
    price: 185000,
    currency: "USD",
    location: {
      district: "Gasabo",
      sector: "Remera",
      neighborhood: "Nyarutarama",
      city: "Kigali",
      province: "Kigali City"
    },
    details: {
      bedrooms: 3,
      bathrooms: 2,
      landSize: 800, // square meters
      builtArea: 250,
      yearBuilt: 2022,
      parking: 2,
      furnished: "semi-furnished",
      security: "24/7 security",
      utilities: ["electricity", "water", "internet", "backup_generator"]
    },
    features: [
      "Modern kitchen with granite countertops",
      "Master bedroom with ensuite bathroom",
      "Landscaped garden with irrigation system",
      "Covered parking for 2 cars",
      "Backup generator",
      "CCTV surveillance system",
      "Close to international schools",
      "10 minutes to CBD"
    ],
    images: [
      require("../assets/images/1.jpeg"),
      require("../assets/images/2.jpeg"),
      require("../assets/images/3.jpg"),
      require("../assets/images/4.jpg")
    ],
    agent: {
      name: "Sarah Mukamana",
      company: "Prime Properties Rwanda",
      phone: "+250-788-123-456",
      email: "sarah.mukamana@primeproperties.rw",
      license: "RPL-2023-001"
    },
    bids: [
      {
        id: 1,
        bidder: "John Uwimana",
        amount: 180000,
        currency: "USD",
        date: "2025-08-25T14:30:00Z",
        status: "active"
      },
      {
        id: 2,
        bidder: "Marie Ingabire",
        amount: 178000,
        currency: "USD", 
        date: "2025-08-24T16:45:00Z",
        status: "outbid"
      }
    ],
    views: 245,
    favorites: 18,
    featured: true,
    verified: true,
    createdAt: "2025-08-15T10:00:00Z",
    updatedAt: "2025-08-25T14:30:00Z"
  },
  {
    id: 2,
    title: "Commercial Building - Kimisagara",
    description: "Prime commercial property in bustling Kimisagara area. Ideal for retail, offices, or mixed-use development. Ground floor + 2 floors with excellent foot traffic.",
    type: "building",
    category: "commercial",
    status: "for_sale",
    price: 320000,
    currency: "USD",
    location: {
      district: "Nyarugenge",
      sector: "Nyarugenge",
      neighborhood: "Kimisagara",
      city: "Kigali",
      province: "Kigali City"
    },
    details: {
      floors: 3,
      totalArea: 450,
      builtArea: 380,
      yearBuilt: 2020,
      parking: 5,
      furnished: "unfurnished",
      utilities: ["electricity", "water", "internet", "commercial_meters"]
    },
    features: [
      "Prime location on main road",
      "High foot traffic area",
      "Ground floor retail space",
      "Upper floors for offices",
      "Separate entrances available",
      "Parking for 5 vehicles",
      "Near public transport",
      "Established commercial district"
    ],
    images: [
      require("../assets/images/5.jpg"),
      require("../assets/images/6.jpg"),
      require("../assets/images/7.jpeg")
    ],
    agent: {
      name: "David Nzeyimana",
      company: "Commercial Realty Rwanda",
      phone: "+250-788-987-654",
      email: "david.n@commercialrealty.rw",
      license: "RPL-2023-015"
    },
    bids: [],
    views: 128,
    favorites: 9,
    featured: false,
    verified: true,
    createdAt: "2025-08-10T09:15:00Z",
    updatedAt: "2025-08-20T11:20:00Z"
  },
  {
    id: 3,
    title: "Luxury Apartment - Kacyiru",
    description: "Upscale 2-bedroom apartment in modern complex. Premium finishes, city views, gym, pool, and concierge services. Perfect for professionals or investment.",
    type: "apartment",
    category: "residential",
    status: "for_rent",
    price: 1200,
    currency: "USD",
    priceType: "monthly",
    location: {
      district: "Gasabo",
      sector: "Kacyiru",
      neighborhood: "Kacyiru",
      city: "Kigali",
      province: "Kigali City"
    },
    details: {
      bedrooms: 2,
      bathrooms: 2,
      builtArea: 120,
      floor: 8,
      totalFloors: 12,
      yearBuilt: 2023,
      parking: 1,
      furnished: "fully-furnished",
      security: "24/7 concierge",
      utilities: ["electricity", "water", "internet", "cable_tv", "gym", "pool"]
    },
    features: [
      "Panoramic city views",
      "Modern fully equipped kitchen",
      "2 ensuite bedrooms",
      "24/7 concierge service",
      "Gym and swimming pool access",
      "High-speed elevator",
      "Backup power system",
      "Walking distance to offices"
    ],
    images: [
      require("../assets/images/8.jpeg"),
      require("../assets/images/9.jpeg"),
      require("../assets/images/10.jpeg")
    ],
    agent: {
      name: "Grace Uwizeyimana",
      company: "Urban Living Rwanda",
      phone: "+250-788-555-777",
      email: "grace.u@urbanliving.rw",
      license: "RPL-2023-008"
    },
    bids: [],
    views: 189,
    favorites: 25,
    featured: true,
    verified: true,
    createdAt: "2025-08-18T11:30:00Z",
    updatedAt: "2025-08-26T09:45:00Z"
  },
  {
    id: 4,
    title: "Development Land - Bugesera",
    description: "25 hectares of prime development land near new Bugesera International Airport. Perfect for residential development, industrial, or mixed-use projects.",
    type: "land",
    category: "development",
    status: "for_sale", 
    price: 450000,
    currency: "USD",
    location: {
      district: "Bugesera",
      sector: "Rilima",
      neighborhood: "Rilima",
      city: "Bugesera",
      province: "Eastern Province"
    },
    details: {
      landSize: 250000, // 25 hectares in square meters
      zoning: "mixed-use",
      utilities: ["electricity_nearby", "water_connection", "road_access"],
      soilType: "fertile",
      elevation: "highland",
      accessibility: "main_road"
    },
    features: [
      "25 hectares of flat, usable land",
      "5km from Bugesera International Airport",
      "Main road frontage",
      "Electricity connection available",
      "Water source on property",
      "Perfect for subdivision",
      "Growing area with development potential",
      "Clear land title available"
    ],
    images: [
      require("../assets/images/11.jpeg"),
      require("../assets/images/1.jpeg")
    ],
    agent: {
      name: "Patrick Habimana",
      company: "Land & Development Rwanda",
      phone: "+250-788-444-333",
      email: "patrick.h@landdevelop.rw",
      license: "RPL-2023-022"
    },
    bids: [
      {
        id: 3,
        bidder: "Diaspora Investment Group",
        amount: 420000,
        currency: "USD",
        date: "2025-08-22T10:15:00Z",
        status: "active"
      }
    ],
    views: 89,
    favorites: 12,
    featured: false,
    verified: true,
    createdAt: "2025-08-12T14:20:00Z",
    updatedAt: "2025-08-22T10:15:00Z"
  },
  {
    id: 5,
    title: "Cozy House - Muhanga Town",
    description: "Charming 2-bedroom house in quiet Muhanga neighborhood. Perfect for small family or rental investment. Garden space and mountain views.",
    type: "house",
    category: "residential",
    status: "for_sale",
    price: 45000,
    currency: "USD",
    location: {
      district: "Muhanga",
      sector: "Muhanga",
      neighborhood: "Muhanga Center",
      city: "Muhanga",
      province: "Southern Province"
    },
    details: {
      bedrooms: 2,
      bathrooms: 1,
      landSize: 400,
      builtArea: 80,
      yearBuilt: 2018,
      parking: 1,
      furnished: "unfurnished",
      utilities: ["electricity", "water", "pit_latrine"]
    },
    features: [
      "Quiet residential neighborhood",
      "Mountain views",
      "Small garden space",
      "Close to schools and market",
      "Public transport accessible",
      "Room for expansion",
      "Affordable investment opportunity"
    ],
    images: [
      require("../assets/images/2.jpeg"),
      require("../assets/images/3.jpg")
    ],
    agent: {
      name: "Agnes Mukasine",
      company: "Rural Properties Rwanda",
      phone: "+250-788-666-888",
      email: "agnes.m@ruralproperties.rw",
      license: "RPL-2023-031"
    },
    bids: [
      {
        id: 4,
        bidder: "James Muhire",
        amount: 42000,
        currency: "USD",
        date: "2025-08-23T13:20:00Z",
        status: "active"
      }
    ],
    views: 156,
    favorites: 8,
    featured: false,
    verified: true,
    createdAt: "2025-08-14T16:10:00Z",
    updatedAt: "2025-08-23T13:20:00Z"
  },
  {
    id: 6,
    title: "Hotel Property - Lake Kivu",
    description: "Established boutique hotel on Lake Kivu shores. 15 rooms, restaurant, conference facilities. Fully operational business with excellent potential.",
    type: "hotel",
    category: "commercial",
    status: "for_sale",
    price: 750000,
    currency: "USD",
    location: {
      district: "Rubavu",
      sector: "Gisenyi",
      neighborhood: "Rubavu",
      city: "Rubavu",
      province: "Western Province"
    },
    details: {
      rooms: 15,
      totalArea: 2000,
      builtArea: 1200,
      yearBuilt: 2015,
      parking: 20,
      furnished: "fully-furnished",
      utilities: ["electricity", "water", "internet", "backup_generator", "septic_system"]
    },
    features: [
      "Prime lakefront location",
      "15 fully equipped rooms",
      "Restaurant with lake views",
      "Conference and event facilities",
      "Private beach access",
      "Landscaped gardens",
      "Established customer base",
      "Tourism business license"
    ],
    images: [
      require("../assets/images/4.jpg"),
      require("../assets/images/5.jpg"),
      require("../assets/images/6.jpg"),
      require("../assets/images/7.jpeg")
    ],
    agent: {
      name: "Robert Nshimiyimana",
      company: "Hospitality Properties Rwanda",
      phone: "+250-788-111-999",
      email: "robert.n@hospitalityproperties.rw",
      license: "RPL-2023-005"
    },
    bids: [
      {
        id: 5,
        bidder: "Tourism Investment Ltd",
        amount: 720000,
        currency: "USD",
        date: "2025-08-26T09:30:00Z",
        status: "active"
      }
    ],
    views: 267,
    favorites: 31,
    featured: true,
    verified: true,
    createdAt: "2025-08-08T12:45:00Z",
    updatedAt: "2025-08-26T09:30:00Z"
  }
];

export const propertyTypes = [
  "villa",
  "apartment", 
  "house",
  "building",
  "land",
  "hotel",
  "office",
  "warehouse",
  "shop"
];

export const propertyCategories = [
  "residential",
  "commercial", 
  "development",
  "industrial",
  "hospitality",
  "agricultural"
];

export const propertyStatuses = [
  "for_sale",
  "for_rent",
  "sold",
  "rented",
  "under_contract"
];

export const rwandaDistricts = [
  "Gasabo", "Kicukiro", "Nyarugenge", // Kigali
  "Muhanga", "Kamonyi", "Ruhango", // Southern Province
  "Rubavu", "Nyabihu", "Ngororero", // Western Province  
  "Bugesera", "Nyanza", "Gisagara", // Eastern/Southern
  "Musanze", "Gakenke", "Burera"    // Northern Province
];

export const currencies = [
  { code: "USD", symbol: "$", name: "US Dollar" },
  { code: "RWF", symbol: "FRw", name: "Rwandan Franc" },
  { code: "EUR", symbol: "€", name: "Euro" }
];

// Helper functions
export const getPropertiesByType = (type) => {
  return dummyProperties.filter(property => property.type === type);
};

export const getPropertiesByCategory = (category) => {
  return dummyProperties.filter(property => property.category === category);
};

export const getPropertiesByStatus = (status) => {
  return dummyProperties.filter(property => property.status === status);
};

export const getFeaturedProperties = () => {
  return dummyProperties.filter(property => property.featured);
};

export const getPropertiesByPriceRange = (minPrice, maxPrice, currency = "USD") => {
  return dummyProperties.filter(property => {
    if (property.currency !== currency) return false;
    return property.price >= minPrice && property.price <= maxPrice;
  });
};

export const getPropertiesByLocation = (district) => {
  return dummyProperties.filter(property => 
    property.location.district.toLowerCase().includes(district.toLowerCase())
  );
};

export const searchProperties = (query) => {
  const lowercaseQuery = query.toLowerCase();
  return dummyProperties.filter(property => 
    property.title.toLowerCase().includes(lowercaseQuery) ||
    property.description.toLowerCase().includes(lowercaseQuery) ||
    property.location.neighborhood.toLowerCase().includes(lowercaseQuery) ||
    property.location.district.toLowerCase().includes(lowercaseQuery) ||
    property.features.some(feature => feature.toLowerCase().includes(lowercaseQuery))
  );
};

export const formatPrice = (price, currency) => {
  const currencyInfo = currencies.find(c => c.code === currency);
  const symbol = currencyInfo ? currencyInfo.symbol : currency;
  
  if (price >= 1000000) {
    return `${symbol}${(price / 1000000).toFixed(1)}M`;
  } else if (price >= 1000) {
    return `${symbol}${(price / 1000).toFixed(0)}K`;
  }
  return `${symbol}${price.toLocaleString()}`;
};

export const getPropertyStats = () => {
  return {
    total: dummyProperties.length,
    forSale: getPropertiesByStatus('for_sale').length,
    forRent: getPropertiesByStatus('for_rent').length,
    featured: getFeaturedProperties().length,
    residential: getPropertiesByCategory('residential').length,
    commercial: getPropertiesByCategory('commercial').length
  };
};