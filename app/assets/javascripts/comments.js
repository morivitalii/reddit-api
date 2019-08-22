$(document).ready(function() {
  var wait = false;
  $(document).mousemove(function(e) {
      if (!wait) {
          guidingLinesHandler(e);
          wait = true;
          setTimeout(function() { wait = false; }, 150);
      }
  });

  $(document).on('click', function(e) {
      var $comments = $(e.target).closest('.comments.highlighted');
      if ($comments.length) {
          var $comment = $comments.closest('.comment');
          $comment.addClass('comment_collapsed');
          var $commentChildrenNum = $comment.find('> .row > .info .comment__children-num');
          if ($commentChildrenNum.text() === '') {
              $commentChildrenNum.text($comments.find('.comment').length);
          }
      }
  });

  var highlighted;
  function guidingLinesHandler(e) {
      var $target = $(e.target),
          $comments,
          $parentComments;

      $comments = $target.closest('.comments');
      $parentComments = $comments.parent().closest('.comments');

      if ($comments.length && $parentComments.length) {
          var domRect = $comments.get(0).getBoundingClientRect();
          var x = Math.round(domRect.x);

          if (e.clientX >= x && e.clientX <= (x + 14)) {
              if (highlighted == $comments.get(0)) {
                  return;
              }

              clearHighlight();
              document.body.classList.add('cursorPointer');
              $comments.get(0).classList.add('highlighted');
              highlighted = $comments.get(0);
          } else {
              clearHighlight();
          }
      } else {
          clearHighlight();
      }
  }

  function clearHighlight() {
      if (highlighted) {
          document.body.classList.remove('cursorPointer');
          highlighted.classList.remove('highlighted');
          highlighted = null;
      }
  }

  $(document).on('click', '.comment__expand', function(e) {
      var $this = $(this);
      var $commentCollapsed = $this.closest('.comment_collapsed');
      $commentCollapsed.removeClass('comment_collapsed');
  });
});