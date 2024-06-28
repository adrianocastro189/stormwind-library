import React from 'react';

const YouTubeEmbed = ({ videoId }) => (
  <div style={{ position: 'relative', paddingBottom: '56.25%', height: 0, overflow: 'hidden', maxWidth: '100%', background: '#000' }}>
    <iframe 
      src={`https://www.youtube.com/embed/${videoId}`} 
      style={{ position: 'absolute', top: 0, left: 0, width: '100%', height: '100%' }} 
      frameBorder="0" 
      allowFullScreen 
      title="YouTube video">
    </iframe>
  </div>
);

export default YouTubeEmbed;