export const formatSalary = (salary) => {
  if (!salary) return '';
  return `$${salary.toLocaleString()}`;
};

export const formatDeadline = (deadline) => {
  return new Date(deadline).toLocaleDateString('en-US', { 
    month: 'short', 
    day: 'numeric', 
    year: 'numeric' 
  });
};

export const getOpportunityIcon = (type) => {
  const iconMap = {
    job: 'Briefcase',
    investment: 'DollarSign',
    scholarship: 'GraduationCap',
    tender: 'Building'
  };
  return iconMap[type] || 'Briefcase';
};

export const getOpportunityColor = (type) => {
  const colorMap = {
    job: 'bg-blue-100 text-blue-800',
    investment: 'bg-green-100 text-green-800',
    scholarship: 'bg-purple-100 text-purple-800',
    tender: 'bg-orange-100 text-orange-800'
  };
  return colorMap[type] || 'bg-gray-100 text-gray-800';
};