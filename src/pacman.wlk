import wollok.game.*

object pacman {
	const property image = "pacman.png"
	var property position = game.origin()
	var vidas = 3

	method perderVida() {
		vidas-=1
		position = game.origin()	
	}
	method juegoTerminado() = vidas == 0
}

class Rival {
	const numero
	
	method image() = "rival" + numero.toString() + ".png"

	method position() = game.at(numero + 1, numero + 1)

}