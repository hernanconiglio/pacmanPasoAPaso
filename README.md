# Pacman!

# Segunda iteración: rivales

## Algunos ajustes al tablero

Con el gimp o cualquier programa de edición, vamos a ajustar el fondo para que tenga menos contraste y se vea con efecto más apagado, para que los personajes y los elementos se distingan más. Además le vamos a poner un título al juego:

```js
program pacman {
	
	game.title("Pacman!")
```

## El rival

Vamos a generar dos rivales inicialmente, que no tienen un comportamiento diferencial, ambos van a ser objetos visuales ubicados en posiciones distintas y con colores diferentes. Entonces una clase rival suena bien, la ubicamos en el archivo `exmample.wlk`:

```wollok
class Rival {
	const numero
	
	method image() = "rival" + numero.toString() + ".png"

	method position() = game.at(numero + 1, numero + 1)
}
```

Al insntanciar a los rivales se le pasa el número, para determinar

- la imagen que va a utilizar: "rival1.png", "rival2.png", etc.
- y la posición inicial que va a ocupar, (2, 2) para el primer rival, (3, 3) para el segundo rival, etc.


## Agregando los rivales al tablero

En el programa pacman incorporamos los dos rivales:

```wollok
program pacman {
    ...

	// rivales
	game.addVisual(new Rival(numero = 1))
	game.addVisual(new Rival(numero = 2))

}
```
## Estrategia de colisión contra los rivales

Si ejecutamos el programa, no tiene mucha gracia: el personaje pasa por encima de sus rivales y éstos, como si nada. Vamos a jugar un poco con estrategia de colisión, cada vez que el personaje choque con un rival

- pierde una vida
- y vuelve a la posición original

Para eso, necesitamos tener una referencia a los rivales. Cambiaremos entonces la forma de instanciarlos en el programa:

```wollok
    // rivales
	const rivales = [new Rival(numero =1), new Rival(numero =2)]
	
	rivales.forEach { rival => 
		game.addVisual(rival)
		game.whenCollideDo(rival, { personaje =>
			personaje.perderVida()
		})
	}
```

Y qué hace el método perderVida() de pacman? Al rival no le importa, la delegación funciona también en los juegos.

## Perdiendo una vida

Ahora sí implementamos la pérdida de la vida del pacman, para eso

- necesitamos contar cuántas vidas tiene, con una referencia a un número nos alcanza
- y actualizar la posición donde se encuentra

```wollok
object pacman {
    ...
	var vidas = 3

	method perderVida() {
		vidas-=1
		position = game.origin()	
	}
```

## Terminando el juego

Un agregado más: vamos a parar el juego cuando el pacman pierda tres vidas. Entonces agregamos una pregunta, pero sin saber que el pacman tiene vidas. En el programa:

```wollok
	rivales.forEach { rival => 
		game.addVisual(rival)
		game.whenCollideDo(rival, { personaje =>
			personaje.perderVida()
			if (personaje.juegoTerminado()) {
				game.stop()
			}
		})
	}
```

Solo nos falta definir el método juegoTerminado() en pacman:

```wollok
method juegoTerminado() = vidas == 0
```

# Demo de cómo quedaría el juego hasta ahora

![video](videos/demo.gif)

# Cómo seguir con el tutorial

Desde una línea de comando, escribí 

```bash
$ git checkout 03-movimiento
$ git pull
```

y leé el archivo README de ese branch. También podés navegar este mismo ejemplo en github:

https://github.com/wollok/pacmanBasicGame

y arriba a la izquierda, donde dice Branch: **master** lo cambiás al **03-movimiento**

