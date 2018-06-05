
[Forma]
Clave=MonCodigoInternacional
Icono=0
CarpetaPrincipal=Ficha
Modulos=(Todos)
Nombre=Código Internacional de Monedas

ListaCarpetas=Ficha
PosicionInicialAlturaCliente=273
PosicionInicialAncho=784
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=291
PosicionInicialArriba=208
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Ficha]
Estilo=Hoja
PestanaOtroNombre=S
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MonCodigoInternacional
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

PermiteEditar=S
[Ficha.MonCodigoInternacional.Codigo]
Carpeta=Ficha
Clave=MonCodigoInternacional.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Ficha.MonCodigoInternacional.Descripcion]
Carpeta=Ficha
Clave=MonCodigoInternacional.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.MonCodigoInternacional.ActualizacionAuto]
Carpeta=Ficha
Clave=MonCodigoInternacional.ActualizacionAuto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Ficha.Columnas]
Codigo=37
Descripcion=304
ActualizacionAuto=304




CodigoNumerico=88
Moneda=69
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S








[Acciones.Navegardor]
Nombre=Navegardor
Boton=0
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador Completo (Registros)
Activo=S
Visible=S






[Acciones.ActializacionAuto]
Nombre=ActializacionAuto
Boton=47
NombreEnBoton=S
NombreDesplegar=Actualización Automática
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=MonActualizacionAuto
Activo=S
Visible=S







[Ficha.MonCodigoInternacional.CodigoNumerico]
Carpeta=Ficha
Clave=MonCodigoInternacional.CodigoNumerico
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


















[Ficha.ListaEnCaptura]
(Inicio)=MonCodigoInternacional.Codigo
MonCodigoInternacional.Codigo=MonCodigoInternacional.CodigoNumerico
MonCodigoInternacional.CodigoNumerico=MonCodigoInternacional.Moneda
MonCodigoInternacional.Moneda=MonCodigoInternacional.Descripcion
MonCodigoInternacional.Descripcion=MonCodigoInternacional.ActualizacionAuto
MonCodigoInternacional.ActualizacionAuto=(Fin)

[Ficha.MonCodigoInternacional.Moneda]
Carpeta=Ficha
Clave=MonCodigoInternacional.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco



















[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=ActializacionAuto
ActializacionAuto=Navegardor
Navegardor=(Fin)
