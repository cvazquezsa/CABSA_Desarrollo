
[Forma]
Clave=TCPinPad
Icono=0
Modulos=(Todos)
Nombre=Interface Tarjetas Bancarias - PinPad
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialIzquierda=441
PosicionInicialArriba=196
PosicionInicialAlturaCliente=267
PosicionInicialAncho=433

ListaAcciones=(Lista)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionCol1=157

[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Datos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TCPinPad
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
ListaEnCaptura=TCPinPad.Pinpad

OtroOrden=S
ListaOrden=TCPinPad.Pinpad<TAB>(Acendente)
[Lista.TCPinPad.Pinpad]
Carpeta=Lista
Clave=TCPinPad.Pinpad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=3
ColorFondo=Blanco

[Lista.Columnas]
Pinpad=79

Fabricante=282
[Detalle]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Detalle
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=TCPinPad
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Detalle.TCPinPad.Modelo]
Carpeta=Detalle
Clave=TCPinPad.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.TCPinPad.Fabricante]
Carpeta=Detalle
Clave=TCPinPad.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.TCPinPad.Velocidad]
Carpeta=Detalle
Clave=TCPinPad.Velocidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Detalle.TCPinPad.BitsDatos]
Carpeta=Detalle
Clave=TCPinPad.BitsDatos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Detalle.TCPinPad.Paridad]
Carpeta=Detalle
Clave=TCPinPad.Paridad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Detalle.TCPinPad.BitsParada]
Carpeta=Detalle
Clave=TCPinPad.BitsParada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Detalle.TCPinPad.CtrlFlujo]
Carpeta=Detalle
Clave=TCPinPad.CtrlFlujo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=Detalle
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S



EspacioPrevio=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S



ConfirmarAntes=S
[Acciones.Navegador 1 (Registros)]
Nombre=Navegador 1 (Registros)
Boton=0
NombreDesplegar=Navegador 1 (Registros)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S


























[Detalle.TCPinPad.Pinpad]
Carpeta=Detalle
Clave=TCPinPad.Pinpad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



















































[Acciones.GuardarCerar]
Nombre=GuardarCerar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S











[Detalle.ListaEnCaptura]
(Inicio)=TCPinPad.Pinpad
TCPinPad.Pinpad=TCPinPad.Modelo
TCPinPad.Modelo=TCPinPad.Fabricante
TCPinPad.Fabricante=TCPinPad.Velocidad
TCPinPad.Velocidad=TCPinPad.BitsDatos
TCPinPad.BitsDatos=TCPinPad.Paridad
TCPinPad.Paridad=TCPinPad.BitsParada
TCPinPad.BitsParada=TCPinPad.CtrlFlujo
TCPinPad.CtrlFlujo=(Fin)





[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=GuardarCerar
GuardarCerar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador 1 (Registros)
Navegador 1 (Registros)=(Fin)
