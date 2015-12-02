$(document).on('click', '#preview-button', function(){
  $('#preview-section').toggle();

  var phrase = $('#phrase_phrase').val();
  var author = $('#phrase_author').val();
  var bgColor = $('#phrase_background').val();
  var fgColor = $('#phrase_foreground').val();

  $('#preview-section .quote-text').text(phrase);
  $('#preview-section .phrase-bottom').text(author);

  $('#preview-section blockquote').css({
      "background-color": bgColor,
      "color": fgColor
  });

  $('hr').css({
      "border-top": "1px solid " + fgColor
  });

});
