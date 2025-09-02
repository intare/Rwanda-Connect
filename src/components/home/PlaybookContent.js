import React, { useState } from 'react';
import { 
  BookOpen, 
  Trophy, 
  Target, 
  Users, 
  TrendingUp,
  Star,
  Clock,
  ChevronRight,
  Play,
  Download,
  Bookmark,
  Share,
  User,
  Calendar,
  Award,
  Lightbulb,
  MessageCircle,
  Search,
  Filter,
  Heart
} from 'lucide-react';

const PlaybookContent = () => {
  const [activeCategory, setActiveCategory] = useState('all');
  const [searchQuery, setSearchQuery] = useState('');

  const categories = [
    { id: 'all', label: 'All', count: 24 },
    { id: 'career', label: 'Career', count: 8 },
    { id: 'success', label: 'Success Stories', count: 6 },
    { id: 'skills', label: 'Skills', count: 5 },
    { id: 'networking', label: 'Networking', count: 3 },
    { id: 'trends', label: 'Industry Trends', count: 2 }
  ];

  const playbookItems = [
    // Career Development Guides
    {
      id: 1,
      category: 'career',
      type: 'guide',
      title: 'Complete Guide to Landing Your Dream Job in Rwanda',
      description: 'Step-by-step strategies for job hunting, from CV writing to interview mastery',
      author: 'Dr. Sarah Uwimana',
      readTime: '15 min read',
      likes: 324,
      bookmarks: 156,
      difficulty: 'Beginner',
      tags: ['Job Search', 'CV Writing', 'Interview'],
      featured: true,
      datePublished: '2025-08-25'
    },
    {
      id: 2,
      category: 'career',
      type: 'video',
      title: 'Negotiating Salary in the Rwandan Market',
      description: 'Learn effective salary negotiation techniques tailored to Rwanda\'s business culture',
      author: 'James Mugisha',
      readTime: '12 min watch',
      likes: 287,
      bookmarks: 143,
      difficulty: 'Intermediate',
      tags: ['Salary', 'Negotiation', 'Career Growth'],
      featured: false,
      datePublished: '2025-08-20'
    },

    // Success Stories
    {
      id: 3,
      category: 'success',
      type: 'story',
      title: 'From Village to Silicon Valley: A Rwandan Tech Success Story',
      description: 'How Jean Claude built a multi-million dollar startup after starting as a rural teacher',
      author: 'Jean Claude Nkurunziza',
      readTime: '8 min read',
      likes: 892,
      bookmarks: 445,
      difficulty: 'Inspirational',
      tags: ['Entrepreneurship', 'Technology', 'Success'],
      featured: true,
      datePublished: '2025-08-28'
    },
    {
      id: 4,
      category: 'success',
      type: 'story',
      title: 'Building Rwanda\'s First Female-Led Fintech Unicorn',
      description: 'The journey of creating a billion-dollar financial technology company',
      author: 'Grace Mukamana',
      readTime: '10 min read',
      likes: 567,
      bookmarks: 234,
      difficulty: 'Advanced',
      tags: ['Fintech', 'Leadership', 'Female Entrepreneurship'],
      featured: true,
      datePublished: '2025-08-22'
    },

    // Skills Development
    {
      id: 5,
      category: 'skills',
      type: 'course',
      title: 'Digital Marketing Mastery for Rwandan Businesses',
      description: 'Complete course on digital marketing strategies that work in the Rwandan market',
      author: 'Rwanda Digital Academy',
      readTime: '2 hours',
      likes: 445,
      bookmarks: 289,
      difficulty: 'Intermediate',
      tags: ['Digital Marketing', 'Business Growth', 'Social Media'],
      featured: false,
      datePublished: '2025-08-18'
    },
    {
      id: 6,
      category: 'skills',
      type: 'guide',
      title: 'Financial Literacy for Young Professionals',
      description: 'Essential financial planning and investment strategies for career starters',
      author: 'Bank of Kigali',
      readTime: '20 min read',
      likes: 678,
      bookmarks: 423,
      difficulty: 'Beginner',
      tags: ['Finance', 'Investment', 'Budgeting'],
      featured: false,
      datePublished: '2025-08-15'
    },

    // Networking & Mentorship
    {
      id: 7,
      category: 'networking',
      type: 'guide',
      title: 'Building Professional Networks in Rwanda',
      description: 'How to create meaningful professional relationships and find mentors',
      author: 'Rwanda Young Professionals Network',
      readTime: '12 min read',
      likes: 234,
      bookmarks: 167,
      difficulty: 'Beginner',
      tags: ['Networking', 'Mentorship', 'Career Development'],
      featured: false,
      datePublished: '2025-08-12'
    },

    // Industry Trends
    {
      id: 8,
      category: 'trends',
      type: 'report',
      title: 'Rwanda Economic Outlook 2025: Emerging Opportunities',
      description: 'Comprehensive analysis of growing sectors and investment opportunities',
      author: 'Rwanda Development Board',
      readTime: '25 min read',
      likes: 156,
      bookmarks: 89,
      difficulty: 'Advanced',
      tags: ['Economy', 'Investment', 'Market Analysis'],
      featured: true,
      datePublished: '2025-08-30'
    }
  ];

  const getTypeIcon = (type) => {
    switch (type) {
      case 'guide': return <BookOpen className="w-4 h-4" />;
      case 'video': return <Play className="w-4 h-4" />;
      case 'story': return <User className="w-4 h-4" />;
      case 'course': return <Target className="w-4 h-4" />;
      case 'report': return <TrendingUp className="w-4 h-4" />;
      default: return <BookOpen className="w-4 h-4" />;
    }
  };

  const getTypeColor = (type) => {
    switch (type) {
      case 'guide': return 'bg-blue-100 text-blue-700';
      case 'video': return 'bg-red-100 text-red-700';
      case 'story': return 'bg-green-100 text-green-700';
      case 'course': return 'bg-purple-100 text-purple-700';
      case 'report': return 'bg-orange-100 text-orange-700';
      default: return 'bg-gray-100 text-gray-700';
    }
  };

  const getDifficultyColor = (difficulty) => {
    switch (difficulty) {
      case 'Beginner': return 'bg-green-50 text-green-700 border-green-200';
      case 'Intermediate': return 'bg-yellow-50 text-yellow-700 border-yellow-200';
      case 'Advanced': return 'bg-red-50 text-red-700 border-red-200';
      case 'Inspirational': return 'bg-purple-50 text-purple-700 border-purple-200';
      default: return 'bg-gray-50 text-gray-700 border-gray-200';
    }
  };

  const filteredItems = playbookItems.filter(item => {
    const matchesCategory = activeCategory === 'all' || item.category === activeCategory;
    const matchesSearch = searchQuery === '' || 
      item.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.description.toLowerCase().includes(searchQuery.toLowerCase()) ||
      item.tags.some(tag => tag.toLowerCase().includes(searchQuery.toLowerCase()));
    
    return matchesCategory && matchesSearch;
  });

  const featuredItems = playbookItems.filter(item => item.featured);

  return (
    <div className="pb-4">
      {/* Header */}
      <div className="sticky top-0 bg-white z-10 pb-4 border-b border-black">
        <div className="px-4 pt-4">
          <div className="mb-6">
            <h1 className="text-2xl font-bold text-black mb-2">Career Playbook</h1>
            <p className="text-gray-600">
              Expert guides, success stories, and resources to accelerate your career in Rwanda
            </p>
          </div>

          {/* Search */}
          <div className="relative mb-4">
            <Search className="absolute left-3 top-3 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search guides, stories, and resources..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-3 bg-white border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
            />
          </div>

          {/* Category Tabs */}
          <div className="flex space-x-1 bg-white p-1 rounded-lg border border-black overflow-x-auto">
            {categories.map((category) => (
              <button
                key={category.id}
                onClick={() => setActiveCategory(category.id)}
                className={`px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap transition-colors ${
                  activeCategory === category.id
                    ? 'bg-black text-white'
                    : 'text-gray-600 hover:text-black hover:bg-gray-100'
                }`}
              >
                {category.label} ({category.count})
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Featured Section */}
      {activeCategory === 'all' && (
        <div className="px-4 mb-6">
          <h2 className="text-lg font-semibold mb-3 text-gray-800">Featured Content</h2>
          <div className="space-y-3">
            {featuredItems.slice(0, 2).map((item) => (
              <div key={item.id} className="bg-black text-white p-6 rounded-lg border border-gray-300">
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="flex items-center mb-2">
                      <div className="bg-gray-800 p-1 rounded mr-2">
                        {getTypeIcon(item.type)}
                      </div>
                      <span className="text-xs bg-gray-800 px-2 py-1 rounded-full capitalize">
                        {item.type}
                      </span>
                      <Star className="w-4 h-4 ml-2 fill-current" />
                    </div>
                    <h3 className="font-bold text-lg mb-2">{item.title}</h3>
                    <p className="text-gray-300 mb-3 text-sm">{item.description}</p>
                    <div className="flex items-center text-sm text-gray-300">
                      <User className="w-3 h-3 mr-1" />
                      <span className="mr-4">{item.author}</span>
                      <Clock className="w-3 h-3 mr-1" />
                      <span>{item.readTime}</span>
                    </div>
                  </div>
                  <ChevronRight className="w-5 h-5 text-white" />
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Content List */}
      <div className="px-4">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-lg font-semibold text-gray-800">
            {activeCategory === 'all' ? 'All Resources' : categories.find(c => c.id === activeCategory)?.label}
          </h2>
          <span className="text-sm text-gray-600">{filteredItems.length} items</span>
        </div>

        <div className="space-y-4">
          {filteredItems.map((item) => (
            <div key={item.id} className="bg-white p-4 rounded-lg border border-black shadow-sm hover:shadow-md transition-shadow">
              {/* Header */}
              <div className="flex items-start justify-between mb-3">
                <div className="flex items-center space-x-2">
                  <div className={`p-2 rounded-lg ${getTypeColor(item.type)}`}>
                    {getTypeIcon(item.type)}
                  </div>
                  <div>
                    <div className="flex items-center space-x-2 mb-1">
                      <span className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded-full capitalize">
                        {item.type}
                      </span>
                      <span className={`text-xs px-2 py-1 rounded-full border ${getDifficultyColor(item.difficulty)}`}>
                        {item.difficulty}
                      </span>
                    </div>
                  </div>
                </div>
                <div className="flex items-center space-x-2">
                  <button className="p-1 text-gray-400 hover:text-red-500 transition-colors">
                    <Heart className="w-4 h-4" />
                  </button>
                  <button className="p-1 text-gray-400 hover:text-blue-500 transition-colors">
                    <Bookmark className="w-4 h-4" />
                  </button>
                  <button className="p-1 text-gray-400 hover:text-gray-600 transition-colors">
                    <Share className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Content */}
              <h3 className="font-semibold text-gray-900 mb-2 hover:text-black cursor-pointer">
                {item.title}
              </h3>
              <p className="text-gray-600 text-sm mb-3 line-clamp-2">
                {item.description}
              </p>

              {/* Tags */}
              <div className="flex flex-wrap gap-2 mb-3">
                {item.tags.map((tag) => (
                  <span key={tag} className="text-xs bg-blue-50 text-blue-700 px-2 py-1 rounded-full">
                    {tag}
                  </span>
                ))}
              </div>

              {/* Footer */}
              <div className="flex items-center justify-between text-sm text-gray-500">
                <div className="flex items-center space-x-4">
                  <div className="flex items-center">
                    <User className="w-3 h-3 mr-1" />
                    {item.author}
                  </div>
                  <div className="flex items-center">
                    <Clock className="w-3 h-3 mr-1" />
                    {item.readTime}
                  </div>
                  <div className="flex items-center">
                    <Calendar className="w-3 h-3 mr-1" />
                    {new Date(item.datePublished).toLocaleDateString()}
                  </div>
                </div>
                <div className="flex items-center space-x-3">
                  <div className="flex items-center">
                    <Heart className="w-3 h-3 mr-1" />
                    {item.likes}
                  </div>
                  <div className="flex items-center">
                    <Bookmark className="w-3 h-3 mr-1" />
                    {item.bookmarks}
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>

        {filteredItems.length === 0 && (
          <div className="text-center py-12">
            <BookOpen className="w-12 h-12 text-gray-300 mx-auto mb-4" />
            <h3 className="text-lg font-medium text-gray-900 mb-2">No resources found</h3>
            <p className="text-gray-600 mb-4">Try adjusting your search or category filter</p>
            <button 
              onClick={() => {
                setSearchQuery('');
                setActiveCategory('all');
              }}
              className="text-black hover:text-gray-600 font-medium"
            >
              Clear filters
            </button>
          </div>
        )}
      </div>

      {/* Quick Actions */}
      <div className="px-4 mt-8">
        <h2 className="text-lg font-semibold mb-3 text-gray-800">Quick Actions</h2>
        <div className="grid grid-cols-2 gap-3">
          <button className="bg-black text-white p-4 rounded-lg text-left hover:bg-gray-800">
            <Lightbulb className="w-6 h-6 mb-2" />
            <h3 className="font-medium mb-1">Submit Your Story</h3>
            <p className="text-xs text-gray-300">Share your success story</p>
          </button>
          <button className="bg-white text-black p-4 rounded-lg border border-black text-left hover:bg-gray-100">
            <MessageCircle className="w-6 h-6 mb-2" />
            <h3 className="font-medium mb-1">Ask Experts</h3>
            <p className="text-xs text-gray-700">Get personalized advice</p>
          </button>
        </div>
      </div>
    </div>
  );
};

export default PlaybookContent;