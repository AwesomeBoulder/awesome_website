$(document).ready(function(){
  $('.apply').tooltip({placement: 'right'});
  $('.nav a').click(function(){
    var id = $(this).attr('href');
    var section = $(id).clone().wrap('<div>').parent().html();
    var active = $('.active_container section');
    console.log(id)
    console.log(section)
    console.log(active)
    active.fadeOut(function(){
      $('.inactive_container').append(active.clone().wrap('<div>').parent().html());
      $('.active_container').html(section).find('section').fadeIn();
    })
    $(this).parents('ul').find('li').removeClass('active');
    $(this).parent().addClass('active');
    
    return false;
   });
});
