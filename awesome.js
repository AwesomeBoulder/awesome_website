$(document).ready(function(){
  $('.apply').tooltip({placement: 'right'});
  $('.apply').live('click', function(){
    _gaq.push(['_trackEvent', 'apply', 'clicked']);
  });
  $('.nav a').click(function(){
    var id = $(this).attr('href');
    var section = $(id).clone().wrap('<div>').parent().html();
    var active = $('.active_container section');
    _gaq.push(['_trackEvent', id, 'clicked']);
    active.fadeOut(function(){
      $('.inactive_container').append(active.clone().wrap('<div>').parent().html());
      $('.active_container').html(section).find('section').fadeIn();
      $('.apply').tooltip({placement: 'right'});
    });
    $(this).parents('ul').find('li').removeClass('active');
    $(this).parent().addClass('active');
    return false;
   });
});

//$(document).bind('window.onhashchange', function(event){
  //console.log('shaboom')
  //console.log(event)
//});
