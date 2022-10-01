import wollok.game.*
object pacman {
	var property image = "pacman.png"
	var property position = game.origin()
	var vidas = 3

	method resetPosition() {
		position = game.origin()
	}
	
	method chocarCon(rival) {
		// sin dudas perdí una vida
		vidas = vidas - 1
		// reset de las posiciones
		self.resetPosition()
		rival.resetPosition()
		// agregamos la validación del juego terminado en pacman
		if (self.juegoTerminado()) {
			game.stop()
		}
	}
	
	method juegoTerminado() = vidas == 0
}

object cherry {
	var property image = "cherry.png"
	var property position = game.center()
}

class Rival {
	const numero
	var property position = game.at(numero + 1, numero + 1)
	var previousPosition = position
	
	method image() = "rival" + numero.toString() + ".png"
	
	method acercarseA(personaje) {
		var otroPosicion = personaje.position()
		var newX = position.x() + if (otroPosicion.x() > position.x()) 1 else -1
		var newY = position.y() + if (otroPosicion.y() > position.y()) 1 else -1
		// evitamos que se posicionen fuera del tablero
		newX = newX.max(0).min(game.width() - 1)
		newY = newY.max(0).min(game.height() - 1)
		previousPosition = position
		position = game.at(newX, newY)
	}
	
	method resetPosition() {
		position = game.at(numero + 1, numero + 1)
	}
	
	method chocarCon(otro) {
		self.resetPreviousPosition()
	}
	
	method resetPreviousPosition() { position = previousPosition }

}