[Forma]
Clave=CfgNominaConceptoMov
Nombre=Nivel Movimiento/Concepto
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=389
PosicionInicialArriba=355
PosicionInicialAlturaCliente=286
PosicionInicialAncho=746
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Clave
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgNominaConceptoMov
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=CfgNominaConceptoMov.ClaveInterna=<T>{Info.Clave}<T>

[Lista.CfgNominaConceptoMov.Mov]
Carpeta=Lista
Clave=CfgNominaConceptoMov.Mov
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Negro
Editar=S
ColorFondo=Blanco

[Lista.CfgNominaConceptoMov.NominaConcepto]
Carpeta=Lista
Clave=CfgNominaConceptoMov.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaConcepto.Concepto]
Carpeta=Lista
Clave=NominaConcepto.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.Columnas]
Mov=124
NominaConcepto=64
Concepto=282
Concepto_1=244

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

[Lista.CfgNominaConceptoMov.Concepto]
Carpeta=Lista
Clave=CfgNominaConceptoMov.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=CfgNominaConceptoMov.Mov
CfgNominaConceptoMov.Mov=CfgNominaConceptoMov.Concepto
CfgNominaConceptoMov.Concepto=CfgNominaConceptoMov.NominaConcepto
CfgNominaConceptoMov.NominaConcepto=NominaConcepto.Concepto
NominaConcepto.Concepto=(Fin)
