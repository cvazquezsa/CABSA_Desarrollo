[Forma]
Clave=SentinelMonitor
Nombre=Monitor (Sentinel)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=464
PosicionInicialArriba=319
PosicionInicialAlturaCliente=358
PosicionInicialAncho=352
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
PestanaOtroNombre=S
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SentinelMonitor
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Estación Trabajo<T>
IconosNombreNumerico=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
MenuLocal=S
IconosNombre=SentinelMonitor:EstacionTrabajo
ListaAcciones=Eliminar

[Lista.Usuario]
Carpeta=Lista
Clave=Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.FechaHora]
Carpeta=Lista
Clave=FechaHora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
0=101
1=107

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Actualizar]
Nombre=Actualizar
Boton=82
NombreDesplegar=Actualizar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=Eliminar
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
ConfirmarAntes=S
DialogoMensaje=EstaSeguro
Expresion=Sentinel.Eliminar( SentinelMonitor:Boleto )<BR> Forma.ActualizarVista

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Actualizar
Actualizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Usuario
Usuario=FechaHora
FechaHora=(Fin)
