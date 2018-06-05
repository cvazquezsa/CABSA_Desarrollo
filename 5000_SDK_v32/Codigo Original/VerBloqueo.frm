[Forma]
Clave=VerBloqueo
Nombre=Monitor de Bloqueos
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=VerBloqueo
AccionesTamanoBoton=15x5
AccionesDerecha=S
BarraHerramientas=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=496
PosicionInicialAncho=804
PosicionSeccion1=50
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
PosicionInicialIzquierda=298
PosicionInicialArriba=260

[VerBloqueo]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Bloqueo(s)
Clave=VerBloqueo
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VerBloqueo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=Spid
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
AutoRefrescar=S
TiempoRefrescar=00:10
IconosNombre=VerBloqueo:Spid

[VerBloqueo.Comando]
Carpeta=VerBloqueo
Clave=Comando
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueo.Info]
Carpeta=VerBloqueo
Clave=Info
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[VerBloqueoD]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Bloqueado(s)
Clave=VerBloqueoD
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=VerBloqueoD
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosSubTitulo=<T>Spid<T>
ListaEnCaptura=(Lista)
IconosNombre=VerBloqueoD:Spid
AutoRefrescar=S
TiempoRefrescar=00:10

[VerBloqueoD.Bloqueado]
Carpeta=VerBloqueoD
Clave=Bloqueado
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueoD.Comando]
Carpeta=VerBloqueoD
Clave=Comando
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueoD.Info]
Carpeta=VerBloqueoD
Clave=Info
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueo.Columnas]
0=40
1=84

[VerBloqueoD.Columnas]
0=49
1=81

[Acciones.Actualizar Vista]
Nombre=Actualizar Vista
Boton=92
NombreEnBoton=S
NombreDesplegar=Actuali&zar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S
EspacioPrevio=S

[VerBloqueo.Inicio]
Carpeta=VerBloqueo
Clave=Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueoD.Inicio]
Carpeta=VerBloqueoD
Clave=Inicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueo.Ahora]
Carpeta=VerBloqueo
Clave=Ahora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueo.UsuarioNT]
Carpeta=VerBloqueo
Clave=UsuarioNT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[VerBloqueoD.UsuarioNT]
Carpeta=VerBloqueoD
Clave=UsuarioNT
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Bitacora]
Nombre=Bitacora
Boton=6
NombreDesplegar=Bitácora
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=VerBloqueo
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=VerBloqueo
VerBloqueo=VerBloqueoD
VerBloqueoD=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Actualizar Vista
Actualizar Vista=Bitacora
Bitacora=(Fin)

[VerBloqueo.ListaEnCaptura]
(Inicio)=UsuarioNT
UsuarioNT=Comando
Comando=Inicio
Inicio=Ahora
Ahora=Info
Info=(Fin)

[VerBloqueoD.ListaEnCaptura]
(Inicio)=Bloqueado
Bloqueado=UsuarioNT
UsuarioNT=Comando
Comando=Inicio
Inicio=Info
Info=(Fin)
