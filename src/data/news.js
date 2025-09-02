export const newsArticles = [
  {
    id: 1,
    title: "Rwanda's Diaspora Remittances Hit Record $500 Million in 2024",
    excerpt: "The National Bank of Rwanda reports a significant increase in diaspora remittances, with funds from Rwandans abroad contributing substantially to the country's economic growth.",
    category: "Economy",
    author: "James Karuhanga",
    publishedDate: "2025-08-30",
    readTime: "4 min read",
    imageUrl: "/news/remittances.jpg",
    source: "The New Times",
    featured: true,
    tags: ["Diaspora", "Economy", "Banking", "Remittances"]
  },
  {
    id: 2,
    title: "Gov't Launches New Platform to Connect Diaspora with Investment Opportunities",
    excerpt: "The Rwanda Development Board unveils a digital platform designed to facilitate diaspora investments in key sectors including technology, agriculture, and tourism.",
    category: "Investment",
    author: "Grace Uwimana",
    publishedDate: "2025-08-28",
    readTime: "6 min read",
    imageUrl: "/news/investment-platform.jpg",
    source: "The New Times",
    featured: true,
    tags: ["Diaspora", "Investment", "Technology", "RDB"]
  },
  {
    id: 3,
    title: "Rwandan Diaspora Convention 2025 Set for December in Kigali",
    excerpt: "Over 2,000 Rwandans living abroad are expected to attend the annual convention, focusing on skills transfer, investment opportunities, and cultural preservation.",
    category: "Events",
    author: "Eric Munyaneza",
    publishedDate: "2025-08-27",
    readTime: "3 min read",
    imageUrl: "/news/diaspora-convention.jpg",
    source: "The New Times",
    featured: false,
    tags: ["Diaspora", "Convention", "Skills Transfer", "Culture"]
  },
  {
    id: 4,
    title: "Success Story: Toronto-Based Rwandan Launches $2M Agritech Startup in Rwanda",
    excerpt: "Marie Mukamana's innovative farming technology startup creates 200 jobs in rural Rwanda while addressing food security challenges across East Africa.",
    category: "Business",
    author: "Peter Nkurunziza",
    publishedDate: "2025-08-26",
    readTime: "5 min read",
    imageUrl: "/news/agritech-success.jpg",
    source: "The New Times",
    featured: true,
    tags: ["Success Story", "Agritech", "Entrepreneurship", "Job Creation"]
  },
  {
    id: 5,
    title: "New Double Taxation Agreement with Canada Benefits Rwandan Diaspora",
    excerpt: "The bilateral agreement eliminates double taxation for Rwandans living in Canada, making it easier for diaspora to invest back home while reducing tax burden.",
    category: "Policy",
    author: "Alice Kayitesi",
    publishedDate: "2025-08-25",
    readTime: "4 min read",
    imageUrl: "/news/tax-agreement.jpg",
    source: "The New Times",
    featured: false,
    tags: ["Policy", "Taxation", "Canada", "Bilateral Agreement"]
  },
  {
    id: 6,
    title: "Diaspora Skills Database Helps Fill Critical Positions in Rwanda's Tech Sector",
    excerpt: "A new initiative matches skilled Rwandans abroad with high-demand positions in the country's growing technology sector, facilitating brain gain over brain drain.",
    category: "Technology",
    author: "David Mugisha",
    publishedDate: "2025-08-24",
    readTime: "3 min read",
    imageUrl: "/news/tech-skills.jpg",
    source: "The New Times",
    featured: false,
    tags: ["Technology", "Skills", "Brain Gain", "Tech Sector"]
  },
  {
    id: 7,
    title: "UK-Based Rwandan Economist Appointed to World Bank Advisory Committee",
    excerpt: "Dr. Claudine Uwera's appointment highlights growing international recognition of Rwandan expertise in economic development and financial policy.",
    category: "International",
    author: "Jean Baptiste Hakizimana",
    publishedDate: "2025-08-23",
    readTime: "2 min read",
    imageUrl: "/news/world-bank-appointment.jpg",
    source: "The New Times",
    featured: false,
    tags: ["International", "World Bank", "Economics", "Recognition"]
  },
  {
    id: 8,
    title: "Diaspora-Funded School Project Transforms Rural Education in Nyanza",
    excerpt: "A community school funded entirely by Rwandan diaspora in Europe opens its doors, providing quality education to 300 students in rural Nyanza district.",
    category: "Education",
    author: "Immaculée Uwimana",
    publishedDate: "2025-08-22",
    readTime: "4 min read",
    imageUrl: "/news/diaspora-school.jpg",
    source: "The New Times",
    featured: false,
    tags: ["Education", "Community Development", "Rural Development", "Diaspora Impact"]
  }
];

// Filter functions for easy access
export const getFeaturedNews = () => newsArticles.filter(article => article.featured);

export const getNewsByCategory = (category) => 
  newsArticles.filter(article => article.category.toLowerCase() === category.toLowerCase());

export const getRecentNews = (limit = 5) => 
  newsArticles.slice(0, limit);

export const searchNews = (query) => {
  const lowercaseQuery = query.toLowerCase();
  return newsArticles.filter(article => 
    article.title.toLowerCase().includes(lowercaseQuery) ||
    article.excerpt.toLowerCase().includes(lowercaseQuery) ||
    article.tags.some(tag => tag.toLowerCase().includes(lowercaseQuery))
  );
};