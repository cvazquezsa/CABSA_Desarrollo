[Forma]
Clave=CtoTipo
Nombre=Tipos de Contactos
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=321
PosicionInicialArriba=317
PosicionInicialAlturaCliente=363
PosicionInicialAncho=637
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtoTipo
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
OtroOrden=S
ListaOrden=(Lista)

[Lista.CtoTipo.Tipo]
Carpeta=Lista
Clave=CtoTipo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtoTipo.SubTipo]
Carpeta=Lista
Clave=CtoTipo.SubTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CtoTipo.Cuenta]
Carpeta=Lista
Clave=CtoTipo.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Cta.Descripcion]
Carpeta=Lista
Clave=Cta.Descripcion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Gris

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

[Lista.Columnas]
Tipo=124
SubTipo=124
Cuenta=124
Descripcion=233

[Acciones.CampoExtra]
Nombre=CampoExtra
Boton=104
NombreEnBoton=S
NombreDesplegar=&Campos Extras
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CtoTipoCampoExtra
Activo=S
ConCondicion=S
Antes=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=ConDatos(CtoTipo:CtoTipo.Tipo) y ConDatos(CtoTipo:CtoTipo.SubTipo)
AntesExpresiones=Asigna(Info.Tipo, CtoTipo:CtoTipo.Tipo)<BR>Asigna(Info.SubTipo, CtoTipo:CtoTipo.SubTipo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CampoExtra
CampoExtra=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CtoTipo.Tipo
CtoTipo.Tipo=CtoTipo.SubTipo
CtoTipo.SubTipo=CtoTipo.Cuenta
CtoTipo.Cuenta=Cta.Descripcion
Cta.Descripcion=(Fin)

[Lista.ListaOrden]
(Inicio)=CtoTipo.Tipo<TAB>(Acendente)
CtoTipo.Tipo<TAB>(Acendente)=CtoTipo.SubTipo<TAB>(Acendente)
CtoTipo.SubTipo<TAB>(Acendente)=CtoTipo.Cuenta<TAB>(Acendente)
CtoTipo.Cuenta<TAB>(Acendente)=(Fin)
