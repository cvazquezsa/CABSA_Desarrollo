
[Forma]
Clave=MFATipoCtaConcepto
Icono=0
Modulos=(Todos)
Nombre=MFA - Cuenta Contable Concepto

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
Vista=MFATipoCtaConcepto
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

[Lista.MFATipoCtaConcepto.Modulo]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFATipoCtaConcepto.Mov]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFATipoCtaConcepto.Categoria]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCtaConcepto.Grupo]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCtaConcepto.Familia]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Familia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFATipoCtaConcepto.Concepto]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MFATipoCtaConcepto.Cuenta]
Carpeta=Lista
Clave=MFATipoCtaConcepto.Cuenta
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
0=207
1=247
2=-2
Modulo=71
Mov=109
Categoria=135
Grupo=155
Familia=129
Concepto=90
Cuenta=124

ConceptoTipo=87

[Lista.MFATipoCtaConcepto.ConceptoTipo]
Carpeta=Lista
Clave=MFATipoCtaConcepto.ConceptoTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=MFATipoCtaConcepto.Modulo
MFATipoCtaConcepto.Modulo=MFATipoCtaConcepto.Mov
MFATipoCtaConcepto.Mov=MFATipoCtaConcepto.Categoria
MFATipoCtaConcepto.Categoria=MFATipoCtaConcepto.Grupo
MFATipoCtaConcepto.Grupo=MFATipoCtaConcepto.Familia
MFATipoCtaConcepto.Familia=MFATipoCtaConcepto.ConceptoTipo
MFATipoCtaConcepto.ConceptoTipo=MFATipoCtaConcepto.Concepto
MFATipoCtaConcepto.Concepto=MFATipoCtaConcepto.Cuenta
MFATipoCtaConcepto.Cuenta=(Fin)
