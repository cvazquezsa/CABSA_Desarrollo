
[Forma]
Clave=WMSAlmPosicion
Icono=0
Modulos=(Todos)
MovModulo=WMSAlmPosicion
Nombre=WMSAlmPosicion

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=347
PosicionInicialAncho=844
PosicionInicialIzquierda=263
PosicionInicialArriba=156
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=S
VentanaEstadoInicial=Normal
Comentarios=<T>Artículo: <T> +<T>  <T> +Info.Articulo
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


OtroOrden=S
PestanaOtroNombre=S
PestanaNombre=Posiciones
Vista=WMSAlmPosicion
ListaOrden=Posicion<TAB>(Acendente)
[Lista.Almacen]
Carpeta=Lista
Clave=Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Tarima]
Carpeta=Lista
Clave=Tarima
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Posicion]
Carpeta=Lista
Clave=Posicion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.Tipo]
Carpeta=Lista
Clave=Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Almacen=100
Tarima=121
Posicion=127
Tipo=139
ArticuloEsp=124







Zona=112


Existencia=64
Apartado=64
Disponible=64
[Lista.Zona]
Carpeta=Lista
Clave=Zona
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Acciones.Paginacion]
Nombre=Paginacion
Boton=0
NombreDesplegar=Paginacion
EnBarraHerramientas=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Paginacion
Activo=S
Visible=S





EspacioPrevio=S




















[Lista.ListaOrden]
(Inicio)=ArticuloEsp	(Acendente)
ArticuloEsp	(Acendente)=Tipo	(Acendente)
Tipo	(Acendente)=(Fin)












[Lista.ListaEnCaptura]
(Inicio)=Almacen
Almacen=Tarima
Tarima=Zona
Zona=Posicion
Posicion=Tipo
Tipo=Existencia
Existencia=Apartado
Apartado=Disponible
Disponible=(Fin)

[Lista.Existencia]
Carpeta=Lista
Clave=Existencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Apartado]
Carpeta=Lista
Clave=Apartado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Disponible]
Carpeta=Lista
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Paginacion
Paginacion=(Fin)
