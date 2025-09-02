import React, { useState } from 'react';
import { 
  Users, 
  MessageCircle, 
  Calendar, 
  User,
  MapPin,
  Clock,
  Heart,
  MessageSquare,
  Share,
  Bookmark,
  Star,
  Award,
  TrendingUp,
  Plus,
  Search,
  Filter,
  UserPlus,
  Handshake,
  Target,
  Zap,
  Globe,
  Coffee,
  Briefcase,
  GraduationCap,
  Code,
  Lightbulb,
  ChevronRight
} from 'lucide-react';

const CommunityContent = () => {
  const [activeTab, setActiveTab] = useState('discussions');
  const [searchQuery, setSearchQuery] = useState('');

  const tabs = [
    { id: 'discussions', label: 'Discussions', icon: MessageCircle, count: 42 },
    { id: 'events', label: 'Events', icon: Calendar, count: 8 },
    { id: 'mentorship', label: 'Mentorship', icon: Users, count: 23 },
    { id: 'groups', label: 'Groups', icon: Target, count: 15 }
  ];

  const discussions = [
    {
      id: 1,
      title: 'Best strategies for transitioning from traditional finance to fintech?',
      author: {
        name: 'Marie Uwimana',
        avatar: '👩‍💼',
        title: 'Senior Analyst at BNR',
        verified: true
      },
      category: 'Career Advice',
      replies: 24,
      likes: 156,
      lastActivity: '2 hours ago',
      trending: true,
      tags: ['Fintech', 'Career Change', 'Finance']
    },
    {
      id: 2,
      title: 'Rwanda Tech Week 2025 - Who\'s attending? Let\'s connect!',
      author: {
        name: 'David Mutabazi',
        avatar: '👨‍💻',
        title: 'Frontend Developer',
        verified: false
      },
      category: 'Networking',
      replies: 18,
      likes: 89,
      lastActivity: '4 hours ago',
      trending: false,
      tags: ['Networking', 'Events', 'Technology']
    },
    {
      id: 3,
      title: 'How to build a successful agritech startup in Rwanda?',
      author: {
        name: 'Jean Baptiste',
        avatar: '🌱',
        title: 'Agricultural Engineer',
        verified: true
      },
      category: 'Entrepreneurship',
      replies: 31,
      likes: 203,
      lastActivity: '6 hours ago',
      trending: true,
      tags: ['Agriculture', 'Startup', 'Innovation']
    }
  ];

  const events = [
    {
      id: 1,
      title: 'Rwanda Startup Pitch Night',
      date: '2025-09-15',
      time: '18:00',
      location: 'kLab, Kigali',
      attendees: 145,
      maxAttendees: 200,
      type: 'In-person',
      organizer: 'Rwanda Startup Community',
      description: 'Monthly pitch event for early-stage startups to present to investors and get feedback',
      tags: ['Startups', 'Pitching', 'Investment'],
      featured: true
    },
    {
      id: 2,
      title: 'Women in Tech Rwanda Meetup',
      date: '2025-09-20',
      time: '17:30',
      location: 'Norrsken House, Kigali',
      attendees: 67,
      maxAttendees: 100,
      type: 'In-person',
      organizer: 'Women in Tech Rwanda',
      description: 'Monthly networking event for women in technology sector',
      tags: ['Women in Tech', 'Networking', 'Technology'],
      featured: false
    },
    {
      id: 3,
      title: 'Digital Finance Innovation Workshop',
      date: '2025-09-25',
      time: '09:00',
      location: 'Virtual Event',
      attendees: 234,
      maxAttendees: 500,
      type: 'Virtual',
      organizer: 'Central Bank of Rwanda',
      description: 'Learn about the latest innovations in digital finance and regulatory framework',
      tags: ['Finance', 'Digital', 'Regulation'],
      featured: true
    }
  ];

  const mentorshipConnections = [
    {
      id: 1,
      mentor: {
        name: 'Dr. Claudine Uwera',
        avatar: '👩‍🔬',
        title: 'CEO, Rwanda Biomedical Centre',
        experience: '15 years',
        expertise: ['Healthcare', 'Leadership', 'Public Health'],
        rating: 4.9,
        sessions: 89
      },
      type: 'seeking',
      description: 'Looking for guidance on healthcare innovation and policy development'
    },
    {
      id: 2,
      mentor: {
        name: 'Patrick Nkulikiyumukiza',
        avatar: '👨‍💼',
        title: 'Senior Software Engineer, Google',
        experience: '12 years',
        expertise: ['Software Engineering', 'Career Growth', 'Tech Leadership'],
        rating: 4.8,
        sessions: 156
      },
      type: 'available',
      description: 'Helping young developers transition into senior roles at tech companies'
    },
    {
      id: 3,
      mentor: {
        name: 'Agnes Kalibata',
        avatar: '🌍',
        title: 'UN Special Envoy for Food Systems',
        experience: '20+ years',
        expertise: ['Agriculture', 'Sustainability', 'International Development'],
        rating: 5.0,
        sessions: 234
      },
      type: 'featured',
      description: 'Mentoring the next generation of agricultural innovators and policy makers'
    }
  ];

  const communityGroups = [
    {
      id: 1,
      name: 'Rwanda Developers Community',
      members: 1247,
      category: 'Technology',
      icon: Code,
      description: 'Connecting software developers across Rwanda',
      activity: 'Very Active',
      recentPost: '2 hours ago'
    },
    {
      id: 2,
      name: 'Young Entrepreneurs Rwanda',
      members: 856,
      category: 'Business',
      icon: Lightbulb,
      description: 'Supporting young entrepreneurs to build successful businesses',
      activity: 'Active',
      recentPost: '4 hours ago'
    },
    {
      id: 3,
      name: 'Rwanda Finance Professionals',
      members: 634,
      category: 'Finance',
      icon: Briefcase,
      description: 'Network of finance and banking professionals',
      activity: 'Moderate',
      recentPost: '1 day ago'
    },
    {
      id: 4,
      name: 'Education Innovation Hub',
      members: 423,
      category: 'Education',
      icon: GraduationCap,
      description: 'Educators working on innovative teaching methods',
      activity: 'Active',
      recentPost: '6 hours ago'
    }
  ];

  const renderDiscussions = () => (
    <div className="space-y-4">
      {discussions.map((discussion) => (
        <div key={discussion.id} className="bg-white p-4 rounded-lg border border-gray-200 hover:shadow-md transition-shadow">
          <div className="flex items-start justify-between mb-3">
            <div className="flex-1">
              <div className="flex items-center mb-2">
                <span className="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded-full">
                  {discussion.category}
                </span>
                {discussion.trending && (
                  <div className="flex items-center ml-2 text-orange-600">
                    <TrendingUp className="w-3 h-3 mr-1" />
                    <span className="text-xs">Trending</span>
                  </div>
                )}
              </div>
              <h3 className="font-semibold text-gray-900 mb-2 hover:text-blue-600 cursor-pointer">
                {discussion.title}
              </h3>
              <div className="flex items-center mb-3">
                <span className="text-2xl mr-2">{discussion.author.avatar}</span>
                <div>
                  <div className="flex items-center">
                    <span className="font-medium text-sm">{discussion.author.name}</span>
                    {discussion.author.verified && (
                      <Award className="w-3 h-3 text-blue-500 ml-1" />
                    )}
                  </div>
                  <span className="text-xs text-gray-500">{discussion.author.title}</span>
                </div>
              </div>
              <div className="flex flex-wrap gap-2 mb-3">
                {discussion.tags.map((tag) => (
                  <span key={tag} className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded-full">
                    {tag}
                  </span>
                ))}
              </div>
            </div>
          </div>
          <div className="flex items-center justify-between text-sm text-gray-500">
            <div className="flex items-center space-x-4">
              <div className="flex items-center">
                <MessageSquare className="w-4 h-4 mr-1" />
                {discussion.replies} replies
              </div>
              <div className="flex items-center">
                <Heart className="w-4 h-4 mr-1" />
                {discussion.likes} likes
              </div>
              <div className="flex items-center">
                <Clock className="w-4 h-4 mr-1" />
                {discussion.lastActivity}
              </div>
            </div>
            <div className="flex items-center space-x-2">
              <button className="p-1 text-gray-400 hover:text-red-500">
                <Heart className="w-4 h-4" />
              </button>
              <button className="p-1 text-gray-400 hover:text-blue-500">
                <Bookmark className="w-4 h-4" />
              </button>
              <button className="p-1 text-gray-400 hover:text-gray-600">
                <Share className="w-4 h-4" />
              </button>
            </div>
          </div>
        </div>
      ))}
    </div>
  );

  const renderEvents = () => (
    <div className="space-y-4">
      {events.map((event) => (
        <div key={event.id} className={`bg-white p-4 rounded-lg border shadow-sm hover:shadow-md transition-shadow ${
          event.featured ? 'border-blue-200 bg-blue-50' : 'border-gray-200'
        }`}>
          <div className="flex items-start justify-between mb-3">
            <div className="flex-1">
              {event.featured && (
                <div className="flex items-center mb-2">
                  <Star className="w-4 h-4 text-blue-600 mr-1" />
                  <span className="text-xs text-blue-600 font-medium">Featured Event</span>
                </div>
              )}
              <h3 className="font-semibold text-gray-900 mb-2">{event.title}</h3>
              <p className="text-sm text-gray-600 mb-3">{event.description}</p>
              
              <div className="flex items-center text-sm text-gray-600 mb-2">
                <Calendar className="w-4 h-4 mr-1" />
                <span className="mr-4">{new Date(event.date).toLocaleDateString()} at {event.time}</span>
                <MapPin className="w-4 h-4 mr-1" />
                <span>{event.location}</span>
              </div>
              
              <div className="flex items-center text-sm text-gray-600 mb-3">
                <Users className="w-4 h-4 mr-1" />
                <span>{event.attendees}/{event.maxAttendees} attendees</span>
                <span className="mx-2">•</span>
                <span className={`px-2 py-1 rounded-full text-xs ${
                  event.type === 'Virtual' ? 'bg-green-100 text-green-700' : 'bg-blue-100 text-blue-700'
                }`}>
                  {event.type}
                </span>
              </div>
              
              <div className="flex flex-wrap gap-2 mb-3">
                {event.tags.map((tag) => (
                  <span key={tag} className="text-xs bg-purple-100 text-purple-700 px-2 py-1 rounded-full">
                    {tag}
                  </span>
                ))}
              </div>
            </div>
          </div>
          
          <div className="flex items-center justify-between">
            <span className="text-sm text-gray-600">by {event.organizer}</span>
            <button className="bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 transition-colors">
              Join Event
            </button>
          </div>
        </div>
      ))}
    </div>
  );

  const renderMentorship = () => (
    <div className="space-y-4">
      {mentorshipConnections.map((connection) => (
        <div key={connection.id} className="bg-white p-4 rounded-lg border border-gray-200 hover:shadow-md transition-shadow">
          <div className="flex items-start space-x-4">
            <div className="text-3xl">{connection.mentor.avatar}</div>
            <div className="flex-1">
              <div className="flex items-center justify-between mb-2">
                <div>
                  <h3 className="font-semibold text-gray-900">{connection.mentor.name}</h3>
                  <p className="text-sm text-gray-600">{connection.mentor.title}</p>
                </div>
                <div className="flex items-center">
                  <Star className="w-4 h-4 text-yellow-500 mr-1" />
                  <span className="text-sm font-medium">{connection.mentor.rating}</span>
                </div>
              </div>
              
              <p className="text-sm text-gray-700 mb-3">{connection.description}</p>
              
              <div className="flex items-center text-sm text-gray-600 mb-3">
                <Clock className="w-4 h-4 mr-1" />
                <span className="mr-4">{connection.mentor.experience} experience</span>
                <MessageCircle className="w-4 h-4 mr-1" />
                <span>{connection.mentor.sessions} sessions completed</span>
              </div>
              
              <div className="flex flex-wrap gap-2 mb-3">
                {connection.mentor.expertise.map((skill) => (
                  <span key={skill} className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded-full">
                    {skill}
                  </span>
                ))}
              </div>
              
              <div className="flex items-center justify-between">
                <div className="flex items-center">
                  {connection.type === 'featured' && (
                    <span className="text-xs bg-purple-100 text-purple-700 px-2 py-1 rounded-full mr-2">
                      Featured Mentor
                    </span>
                  )}
                  {connection.type === 'available' && (
                    <span className="text-xs bg-green-100 text-green-700 px-2 py-1 rounded-full mr-2">
                      Available Now
                    </span>
                  )}
                  {connection.type === 'seeking' && (
                    <span className="text-xs bg-blue-100 text-blue-700 px-2 py-1 rounded-full mr-2">
                      Seeking Mentees
                    </span>
                  )}
                </div>
                <button className="flex items-center bg-blue-600 text-white px-4 py-2 rounded-lg text-sm font-medium hover:bg-blue-700 transition-colors">
                  <Handshake className="w-4 h-4 mr-1" />
                  Connect
                </button>
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );

  const renderGroups = () => (
    <div className="grid grid-cols-1 gap-4">
      {communityGroups.map((group) => (
        <div key={group.id} className="bg-white p-4 rounded-lg border border-gray-200 hover:shadow-md transition-shadow">
          <div className="flex items-start space-x-4">
            <div className="p-3 bg-blue-100 rounded-lg">
              <group.icon className="w-6 h-6 text-blue-600" />
            </div>
            <div className="flex-1">
              <div className="flex items-center justify-between mb-2">
                <h3 className="font-semibold text-gray-900">{group.name}</h3>
                <div className="flex items-center text-sm text-gray-600">
                  <Users className="w-4 h-4 mr-1" />
                  {group.members.toLocaleString()}
                </div>
              </div>
              
              <p className="text-sm text-gray-600 mb-2">{group.description}</p>
              
              <div className="flex items-center justify-between">
                <div className="flex items-center space-x-4 text-sm text-gray-600">
                  <span className="text-xs bg-gray-100 text-gray-700 px-2 py-1 rounded-full">
                    {group.category}
                  </span>
                  <div className="flex items-center">
                    <Zap className="w-3 h-3 mr-1" />
                    {group.activity}
                  </div>
                  <div className="flex items-center">
                    <Clock className="w-3 h-3 mr-1" />
                    {group.recentPost}
                  </div>
                </div>
                <button className="flex items-center bg-blue-600 text-white px-3 py-1 rounded-lg text-sm font-medium hover:bg-blue-700 transition-colors">
                  <UserPlus className="w-3 h-3 mr-1" />
                  Join
                </button>
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );

  const renderContent = () => {
    switch (activeTab) {
      case 'discussions': return renderDiscussions();
      case 'events': return renderEvents();
      case 'mentorship': return renderMentorship();
      case 'groups': return renderGroups();
      default: return renderDiscussions();
    }
  };

  return (
    <div className="pb-4">
      {/* Header */}
      <div className="sticky top-0 bg-white z-10 pb-4 border-b border-black">
        <div className="px-4 pt-4">
          <div className="mb-6">
            <h1 className="text-2xl font-bold text-black mb-2">Community</h1>
            <p className="text-gray-600">
              Connect, learn, and grow with Rwanda's professional community
            </p>
          </div>

          {/* Search */}
          <div className="relative mb-4">
            <Search className="absolute left-3 top-3 w-4 h-4 text-gray-400" />
            <input
              type="text"
              placeholder="Search discussions, events, mentors..."
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
              className="w-full pl-10 pr-4 py-3 bg-white border border-black rounded-lg focus:ring-2 focus:ring-gray-500 focus:border-black"
            />
          </div>

          {/* Tabs */}
          <div className="flex space-x-1 bg-white p-1 rounded-lg border border-black overflow-x-auto">
            {tabs.map((tab) => (
              <button
                key={tab.id}
                onClick={() => setActiveTab(tab.id)}
                className={`flex items-center px-3 py-2 rounded-md text-sm font-medium whitespace-nowrap transition-colors ${
                  activeTab === tab.id
                    ? 'bg-black text-white'
                    : 'text-gray-600 hover:text-black hover:bg-gray-100'
                }`}
              >
                <tab.icon className="w-4 h-4 mr-1" />
                {tab.label} ({tab.count})
              </button>
            ))}
          </div>
        </div>
      </div>

      {/* Action Button */}
      <div className="px-4 mb-4">
        <button className="w-full bg-black text-white p-4 rounded-lg font-medium flex items-center justify-center hover:bg-gray-800 transition-colors">
          <Plus className="w-5 h-5 mr-2" />
          {activeTab === 'discussions' && 'Start a Discussion'}
          {activeTab === 'events' && 'Create an Event'}
          {activeTab === 'mentorship' && 'Become a Mentor'}
          {activeTab === 'groups' && 'Create a Group'}
        </button>
      </div>

      {/* Content */}
      <div className="px-4">
        {renderContent()}
      </div>

      {/* Community Stats */}
      <div className="px-4 mt-8">
        <h2 className="text-lg font-semibold mb-3 text-gray-800">Community Impact</h2>
        <div className="grid grid-cols-2 gap-3">
          <div className="bg-white p-4 rounded-lg border border-gray-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-blue-600 font-semibold text-lg">2,847</p>
                <p className="text-blue-700 text-sm">Active Members</p>
              </div>
              <Users className="w-6 h-6 text-blue-600" />
            </div>
          </div>
          
          <div className="bg-white p-4 rounded-lg border border-gray-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-green-600 font-semibold text-lg">156</p>
                <p className="text-green-700 text-sm">Mentor Connections</p>
              </div>
              <Handshake className="w-6 h-6 text-green-600" />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CommunityContent;