[Forma]
Clave=CampanaTipoEncuesta
Nombre=Encuesta del Tipo Campaña
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=544
PosicionInicialArriba=400
PosicionInicialAlturaCliente=364
PosicionInicialAncho=831
PosicionCol1=576
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Tipo

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CampanaTipoEncuesta
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
Filtros=S
OtroOrden=S
ListaOrden=CampanaTipoEncuesta.Orden<TAB>(Acendente)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=CampanaTipoEncuesta.CampanaTipo=<T>{Info.Tipo}<T>

[Lista.CampanaTipoEncuesta.Campo]
Carpeta=Lista
Clave=CampanaTipoEncuesta.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaTipoEncuesta.Nombre]
Carpeta=Lista
Clave=CampanaTipoEncuesta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.CampanaTipoEncuesta.Orden]
Carpeta=Lista
Clave=CampanaTipoEncuesta.Orden
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CampanaTipoEncuesta
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.CampanaTipoEncuesta.Campo]
Carpeta=Ficha
Clave=CampanaTipoEncuesta.Campo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipoEncuesta.Nombre]
Carpeta=Ficha
Clave=CampanaTipoEncuesta.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipoEncuesta.Descripcion]
Carpeta=Ficha
Clave=CampanaTipoEncuesta.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30x4
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipoEncuesta.Tipo]
Carpeta=Ficha
Clave=CampanaTipoEncuesta.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipoEncuesta.TablaEvaluacion]
Carpeta=Ficha
Clave=CampanaTipoEncuesta.TablaEvaluacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CampanaTipoEncuesta.Peso]
Carpeta=Ficha
Clave=CampanaTipoEncuesta.Peso
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=6

[Lista.Columnas]
Campo=148
Nombre=355
Orden=40

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

[Acciones.Ayuda]
Nombre=Ayuda
Boton=47
NombreEnBoton=S
NombreDesplegar=&Ayuda
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CampanaTipoEncuestaLista
ConCondicion=S
Antes=S
Visible=S
ActivoCondicion=CampanaTipoEncuesta:CampanaTipoEncuesta.Tipo=<T>Datos<T>
EjecucionCondicion=ConDatos(CampanaTipoEncuesta:CampanaTipoEncuesta.Campo)
AntesExpresiones=Asigna(Info.Campo, CampanaTipoEncuesta:CampanaTipoEncuesta.Campo)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Ayuda
Ayuda=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=CampanaTipoEncuesta.Campo
CampanaTipoEncuesta.Campo=CampanaTipoEncuesta.Nombre
CampanaTipoEncuesta.Nombre=CampanaTipoEncuesta.Orden
CampanaTipoEncuesta.Orden=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=CampanaTipoEncuesta.Campo
CampanaTipoEncuesta.Campo=CampanaTipoEncuesta.Nombre
CampanaTipoEncuesta.Nombre=CampanaTipoEncuesta.Descripcion
CampanaTipoEncuesta.Descripcion=CampanaTipoEncuesta.Tipo
CampanaTipoEncuesta.Tipo=CampanaTipoEncuesta.TablaEvaluacion
CampanaTipoEncuesta.TablaEvaluacion=CampanaTipoEncuesta.Peso
CampanaTipoEncuesta.Peso=(Fin)
