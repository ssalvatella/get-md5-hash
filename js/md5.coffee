###############################################################
#                                                             #
# Autor: Samuel Salvatella                                    #
# NIA: 680350                                                 #
# Script en CoffeScript que dado un texto de entrada devuelve #
# el hash correspodiente mediante el algoritmo MD5. La imple- #
# mentación se ha realizado siguiendo la descripción de:      #
# https://es.wikipedia.org/wiki/MD5#Algoritmo                 #
#                                                             #
###############################################################


# Definimos las funciones auxiliares que necesitaremos para
# la implementación del algoritmo.

# Desplaza los bits una palabra a la izquierda
desplazarIzquierda = (x, y) ->
	x << y | x >>> 32 - y;

# Función que devuelve un hexadecimal como una cadena de texto.
devuelveCadena = do ->
	hex = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
	hex = (hex[x >> 4] + hex[x & 15] for x in [0..255])
	(entrada) ->
	  (hex[caracter.charCodeAt()] for caracter in entrada).join ''	

md5 = do -> 

  s = [738695, 669989, 770404, 703814]
  s = (s[i >> 4] >> i % 4 * 5 & 31 for i in [0..63]) 

  # Tabla T construida con la función seno (ver paso 4)
  # Usaremos esta tabla en el ultimo paso.
  T = (Math.floor Math.pow(2,32) * Math.abs Math.sin i for i in [1..64])
 
  (input) ->
  
    # Creamos el vector en el que guardar los bits del 
    # mensaje cifrado. 
    len = input.length * 8
    M[len >> 5] |= 128 << len % 32
    M[(len + 64 >>> 9 << 4) + 14] = len
  
    # Inicializamos el búfer
    # (ver paso 3 https://es.wikipedia.org/wiki/MD5#Algoritmo)
    a0 = 0x67452301;
    b0 = 0xefcdab89
    c0 = 0x98badcfe;
    d0 = 0x10325476;
 
    # Dividimos el texto en palabras de 32 bits en "litle endian".
    M = 
      for i in [0...input.length] by 4
        sum (input.charCodeAt(i + j) << j*8 for j in [0..3])
 

 
    # Procesamos el texto en bloques de 16 palabras (32 bits cada una)
    # (ver paso 4)
    for x in [0...M.length] by 16
      [A, X, Y, Z] = [a0, b0, c0, d0]
 
      # Paso 4
      for i in [0..63]
        if i < 16
          F = X & Y | ~X & Z
          g = i
        else if i < 32
          F = X & Z | Y & ~Z
          g = i * 5 + 1
        else if i < 48
          F = X ^ Y ^ Z
          g = i * 3 + 5
        else
          F = Y ^ (X | ~Z)
          g = i * 7
 
        [A, X, C, Z] =
          [Z, X + desplazarIzquierda(A + F + T[i] + (M[x + g % 16] ? 0), s[i]), X, Y]
 
      a0 += A
      b0 += X
      c0 += Y
      d0 += Z
 
    # Devolvemos los 4 bloques transformados en una palabra
    return (
      for x in [a0, b0, c0, d0]
        (String.fromCharCode x >>> 8 * y & 255 for y in [0..3]).join ''
    ).join ''


    
devuelve_md5 = (texto) ->
    devuelveCadena md5 texto

# Exportamos la función que devuelve el Hash	
root = exports ? this
root.devuelve_MD5 = devuelve_md5
