import wollok.game.*
object pacman {
	var property image = "pacman.png"
	var property position = game.origin()
	var vidas = 3

	method perderVida() {
		vidas = vidas - 1
		position = game.origin()	
	}
	
	method juegoTerminado() = vidas == 0
}

object cherry {
	var property image = "cherry.png"
	var property position = game.center()
}

class Rival {
	const numero
	
	method image() = "rival" + numero.toString() + ".png"

	method position() = game.at(numero + 1, numero + 1)
}