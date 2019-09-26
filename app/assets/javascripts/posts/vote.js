$(document).ready(function () {
  $(document).on('ajax:success', '.post__votes', function (e) {
    var up_vote_link = e.detail[0].up_vote_link
    var down_vote_link = e.detail[0].down_vote_link
    var score = e.detail[0].score

    $(this).find('.post__score').replaceWith(score)
    $(this).find('.post__up-vote-link').replaceWith(up_vote_link)
    $(this).find('.post__down-vote-link').replaceWith(down_vote_link)
  })
})
