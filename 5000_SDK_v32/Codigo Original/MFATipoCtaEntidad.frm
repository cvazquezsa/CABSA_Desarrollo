
[Forma]
Clave=MFATipoCtaEntidad
Icono=0
Modulos=(Todos)
Nombre=MFA - Cuenta Contable Entidad

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
PosicionInicialIzquierda=50
PosicionInicialArriba=118
PosicionInicialAlturaCliente=389
PosicionInicialAncho=941
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFATipoCtaEntidad
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

[Lista.MFATipoCtaEntidad.Modulo]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFATipoCtaEntidad.Mov]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFATipoCtaEntidad.Categoria]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCtaEntidad.Grupo]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCtaEntidad.Familia]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCtaEntidad.Entidad]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Entidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MFATipoCtaEntidad.Cuenta]
Carpeta=Lista
Clave=MFATipoCtaEntidad.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

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
0=-2
1=-2
2=-2
Modulo=71
Mov=109
Categoria=135
Grupo=155
Familia=129
Entidad=90
Cuenta=124

EntidadTipo=87

[Lista.MFATipoCtaEntidad.EntidadTipo]
Carpeta=Lista
Clave=MFATipoCtaEntidad.EntidadTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.ListaEnCaptura]
(Inicio)=MFATipoCtaEntidad.Modulo
MFATipoCtaEntidad.Modulo=MFATipoCtaEntidad.Mov
MFATipoCtaEntidad.Mov=MFATipoCtaEntidad.Categoria
MFATipoCtaEntidad.Categoria=MFATipoCtaEntidad.Grupo
MFATipoCtaEntidad.Grupo=MFATipoCtaEntidad.Familia
MFATipoCtaEntidad.Familia=MFATipoCtaEntidad.EntidadTipo
MFATipoCtaEntidad.EntidadTipo=MFATipoCtaEntidad.Entidad
MFATipoCtaEntidad.Entidad=MFATipoCtaEntidad.Cuenta
MFATipoCtaEntidad.Cuenta=(Fin)
