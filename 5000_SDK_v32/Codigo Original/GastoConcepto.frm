[Forma]
Clave=GastoConcepto
Nombre=<T>Conceptos - Gastos<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=758
PosicionInicialArriba=391
PosicionInicialAltura=409
PosicionInicialAncho=404
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Clase, Info.SubClase)
PosicionInicialAlturaCliente=382

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=GastoConcepto
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Concepto<T>
ElementosPorPagina=200
PestanaOtroNombre=S
PestanaNombre=Conceptos
PermiteLocalizar=S
IconosNombre=GastoConcepto:Concepto

[Lista.Columnas]
Concepto=252
0=252

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S
Antes=S
AntesExpresiones=Asigna(Info.Concepto,GastoConcepto:Concepto)

[Acciones.Todos]
Nombre=Todos
Boton=55
NombreEnBoton=S
NombreDesplegar=Ver &Todos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Antes=S
Multiple=S
ListaAccionesMultiples=Actualizar Vista<BR>Actualizar Forma
Visible=S
ActivoCondicion=ConDatos(Info.Clase)
AntesExpresiones=Asigna(Info.Clase, Nulo)<BR>Asigna(Info.SubClase, Nulo)

[Acciones.Todos.Actualizar Forma]
Nombre=Actualizar Forma
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Titulos
Activo=S
Visible=S

[Acciones.Todos.Actualizar Vista]
Nombre=Actualizar Vista
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Actualizar Vista
Activo=S
Visible=S

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreEnBoton=S
NombreDesplegar=&Localizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Todos
Todos=Localizar
Localizar=(Fin)
