[Forma]
Clave=Consecutivo
Nombre=Consecutivos Generales
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=396
PosicionInicialArriba=207
PosicionInicialAltura=280
PosicionInicialAncho=573
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=318

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Consecutivo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
PermiteEditar=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S

[Lista.Consecutivo.Tipo]
Carpeta=Lista
Clave=Consecutivo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Consecutivo.Nivel]
Carpeta=Lista
Clave=Consecutivo.Nivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=131
Nivel=85
Prefijo=48
Consecutivo=127
TieneControl=68
Concurrencia=70

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Sucursales]
Nombre=Sucursales
Boton=47
NombreEnBoton=S
NombreDesplegar=&Sucursales
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ConsecutivoSucursal
Antes=S
Visible=S
ActivoCondicion=Consecutivo:Consecutivo.Nivel=<T>Sucursal<T>
AntesExpresiones=Asigna(Info.Tipo, Consecutivo:Consecutivo.Tipo)

[Lista.Consecutivo.Prefijo]
Carpeta=Lista
Clave=Consecutivo.Prefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Consecutivo.Consecutivo]
Carpeta=Lista
Clave=Consecutivo.Consecutivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Consecutivo.TieneControl]
Carpeta=Lista
Clave=Consecutivo.TieneControl
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Control]
Nombre=Control
Boton=47
NombreEnBoton=S
NombreDesplegar=&Control Consecutivos
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ConsecutivoControl
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Consecutivo:Consecutivo.TieneControl
AntesExpresiones=Asigna(Info.Tipo, Consecutivo:Consecutivo.Tipo)

[Lista.Consecutivo.Concurrencia]
Carpeta=Lista
Clave=Consecutivo.Concurrencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=Consecutivo.Tipo
Consecutivo.Tipo=Consecutivo.Nivel
Consecutivo.Nivel=Consecutivo.TieneControl
Consecutivo.TieneControl=Consecutivo.Prefijo
Consecutivo.Prefijo=Consecutivo.Concurrencia
Consecutivo.Concurrencia=Consecutivo.Consecutivo
Consecutivo.Consecutivo=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Sucursales
Sucursales=Control
Control=(Fin)
