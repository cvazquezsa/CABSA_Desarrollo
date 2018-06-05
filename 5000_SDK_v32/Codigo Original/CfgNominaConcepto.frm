[Forma]
Clave=CfgNominaConcepto
Nombre=Configuración Conceptos Nómina
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=463
PosicionInicialArriba=142
PosicionInicialAlturaCliente=588
PosicionInicialAncho=513
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CfgNominaConcepto
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
OtroOrden=S
ListaOrden=CfgNominaConcepto.Descripcion<TAB>(Acendente)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=Cfgnominaconcepto.Pais=<T>{Empresa.Pais}<T>
FiltroRespetar=S
FiltroTipo=General

[Lista.CfgNominaConcepto.Descripcion]
Carpeta=Lista
Clave=CfgNominaConcepto.Descripcion
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.CfgNominaConcepto.NominaConcepto]
Carpeta=Lista
Clave=CfgNominaConcepto.NominaConcepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ClaveInterna=140
Descripcion=196
NominaConcepto=88
Concepto=199

[Lista.NominaConcepto.Concepto]
Carpeta=Lista
Clave=NominaConcepto.Concepto
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

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

[Acciones.Mov]
Nombre=Mov
Boton=47
NombreEnBoton=S
NombreDesplegar=&Nivel Movimiento/Concepto
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CfgNominaConceptoMov
Visible=S
Antes=S
ActivoCondicion=CfgNominaConcepto:CfgNominaConcepto.ClaveInterna=<T>Cxc<T>
AntesExpresiones=Asigna(Info.Modulo, <T>CXC<T>)<BR>Asigna(Info.Clave, CfgNominaConcepto:CfgNominaConcepto.ClaveInterna)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Mov
Mov=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CfgNominaConcepto.Descripcion
CfgNominaConcepto.Descripcion=NominaConcepto.Concepto
NominaConcepto.Concepto=CfgNominaConcepto.NominaConcepto
CfgNominaConcepto.NominaConcepto=(Fin)
