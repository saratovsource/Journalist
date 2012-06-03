$(function(){
  $('a[data-hide-after-click]').each(function(){
    $(this).bind('ajax:complete', function(){
      var parent_item = $(this).closest($(this).data('hide-after-click'));
      parent_item.fadeOut();
    });
  });
});
