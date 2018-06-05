[Forma]
Clave=SeguroTipoPoliza
Nombre=Tipos Pólizas (Seguros)
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=473
PosicionInicialArriba=312
PosicionInicialAlturaCliente=365
PosicionInicialAncho=333
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
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
Vista=SeguroTipoPoliza
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=SeguroTipoPoliza.Tipo
CarpetaVisible=S

[Lista.SeguroTipoPoliza.Tipo]
Carpeta=Lista
Clave=SeguroTipoPoliza.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Tipo=304

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

[Acciones.Excepciones]
Nombre=Excepciones
Boton=30
NombreEnBoton=S
NombreDesplegar=&Excepciones
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SeguroTipoPolizaEx
ConCondicion=S
Antes=S
DespuesGuardar=S
Visible=S
Activo=S
EjecucionCondicion=ConDatos(SeguroTipoPoliza:SeguroTipoPoliza.Tipo)
AntesExpresiones=Asigna(Info.Tipo, SeguroTipoPoliza:SeguroTipoPoliza.Tipo)

[Acciones.Cobertura]
Nombre=Cobertura
Boton=47
NombreEnBoton=S
NombreDesplegar=&Cobertura
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=SeguroTipoPolizaCobertura
ConCondicion=S
Visible=S
GuardarAntes=S
Antes=S
DespuesGuardar=S
EjecucionCondicion=ConDatos(SeguroTipoPoliza:SeguroTipoPoliza.Tipo)
AntesExpresiones=Asigna(Info.Tipo, SeguroTipoPoliza:SeguroTipoPoliza.Tipo)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excepciones
Excepciones=Cobertura
Cobertura=(Fin)
