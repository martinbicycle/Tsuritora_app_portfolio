// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage

//= require_tree .
//= require underscore
//= require gmaps/google

$(document).ready(function () {
  $("#theTarget").skippr({
    // スライドショーの変化 ("fade" or "slide")
    transition : 'slide',
    // 変化に係る時間(ミリ秒)
    speed : 1000,
    // easingの種類
    easing : 'easeOutQuart',
    // ナビゲーションの形("block" or "bubble")
    navType : false,
    // 子要素の種類('div' or 'img')
    childrenElementType : 'div',
    // ナビゲーション矢印の表示(trueで表示)
    arrows : false,
    // スライドショーの自動再生(falseで自動再生なし)
    autoPlay : true,
    // 自動再生時のスライド切替間隔(ミリ秒)
    autoPlayDuration : 2500,
    // キーボードの矢印キーによるスライド送りの設定(trueで有効)
    keyboardOnAlways : false,
    // 一枚目のスライド表示時に戻る矢印を表示するかどうか(falseで非表示)
    hidePrevious : false
  });
});


$(function() {
   $('#files').css({
       'position': 'absolute',
       'top': '-9999px'
   }).change(function() {
       var val = $(this).val();
       var path = val.replace(/\\/g, '/');
       var match = path.lastIndexOf('/');
  $('#filename').css("display","inline-block");
       $('#filename').val(match !== -1 ? val.substring(match + 1) : val);
   });
   $('#filename').bind('keyup, keydown, keypress', function() {
       return false;
   });
   $('#filename, #btn').click(function() {
       $('#files').trigger('click');
   });

   document.querySelectorAll(".form-icons .form-icon .toggle-icon").forEach(el => {
    el.addEventListener("click", formIconToggle)
  })
});



function formIconToggle(event) {
  const icon = event.target
  const wrapFormIconEl = icon.parentElement
  const input = wrapFormIconEl.nextElementSibling
  if (input.value === "0") {
    icon.classList.add("active")
    input.value = 1
  } else {
    icon.classList.remove("active")
    input.value = 0
  }
}