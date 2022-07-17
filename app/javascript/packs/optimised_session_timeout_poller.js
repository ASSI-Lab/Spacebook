var IDLE_TIMEOUT = 900; //seconds
var _idleSecondsCounter = 0;
document.onclick = function() {
  _idleSecondsCounter = 0;
};
document.onmousemove = function() {
  _idleSecondsCounter = 0;
};
document.onkeydown = function() {
  _idleSecondsCounter = 0;
};

var myInterval = window.setInterval(CheckIdleTime, 1000);// INTERVALLO DI TEMPO 

function CheckIdleTime() {
  _idleSecondsCounter++;
  var oPanel = document.getElementById("SecondsUntilExpire");
  if (oPanel)
    oPanel.innerHTML = (IDLE_TIMEOUT - _idleSecondsCounter) + "";
  if (_idleSecondsCounter >= IDLE_TIMEOUT) {
    window.location.href = '/session_timeout';// FORZA LA DISCONNESSIONE IN CASO DI TEMPI DISCORDI TRA DEVISE E APPLICAZIONE
    alert("Sessione scaduta sarai reindirizzato al login!");// PER IL MOMENTO UTILIZZO UN ALERT CHE REINDIRIZZA SOLO DOPO LA PRESSIONE DEL TASTO OK
    window.clearInterval(myInterval);
  }
}