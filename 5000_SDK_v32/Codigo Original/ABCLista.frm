
[Forma]
Clave=ABCLista
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=ABC
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
VentanaEstadoInicial=Normal

ListaAcciones=(Lista)
Comentarios=Info.Mov
PosicionInicialIzquierda=527
PosicionInicialArriba=250
PosicionInicialAlturaCliente=273
PosicionInicialAncho=225
ListaCarpetas=Lista
CarpetaPrincipal=Lista
[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
ConCondicion=S
Visible=S

EjecucionCondicion=ConDatos(ABC:ABC.ABC)
[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar Vista
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S




[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=ABC
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ABC
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>ABC<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S



ListaEnCaptura=ABC.ABC
[Lista.Columnas]
0=211
1=-2






[Lista.ABC.ABC]
Carpeta=Lista
Clave=ABC.ABC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro







[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Personalizar
Personalizar=(Fin)
