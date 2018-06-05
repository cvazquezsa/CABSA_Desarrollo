[Forma]
Clave=NomXFormula
Nombre=<T>Fórmulas y Acumuladores para Calcular la Nómina<T>
Icono=9
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=145
PosicionInicialArriba=155
PosicionInicialAltura=451
PosicionInicialAncho=734
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionSeccion1=86
PosicionColumna1=38
Comentarios=Info.Nombre
PosicionInicialAlturaCliente=424

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NomXFormula
Fuente={MS Sans Serif, 10, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=NomXFormula.Formula
CarpetaVisible=S
MenuLocal=S
ListaAcciones=(Lista)
HojaConfirmarEliminar=S
OtroOrden=S
ListaOrden=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroGrupo1=NomXFormula.Tipo
FiltroValida1=NomXFormula.Tipo
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
FiltroAplicaEn=NomXFormula.Tipo
FiltroAutoCampo=NomXFormula.Tipo
FiltroAutoValidar=NomXFormula.Tipo
FiltroPredefinido1=Fórmulas<BR>Acumuladores
FiltroPredefinido2=NomXFormula.Tipo=<T>Formula<T><BR>NomXFormula.Tipo=<T>Acumulador<T>
FiltroPredefinido3=Orden<BR>Orden
FiltroEstilo=Directorio
HojaMantenerSeleccion=S
FiltroGeneral=NomXFormula.ID={Info.ID}

[Lista.NomXFormula.Formulaulo]
Carpeta=Lista
Clave=NomXFormula.Formula
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S
ConCondicion=S
EjecucionConError=S
EspacioPrevio=S
EjecucionCondicion=Asigna(Temp.Texto, ListaBuscarDuplicados(CampoEnLista(NomXFormula:NomXFormula.Formula)))<BR>Vacio(Temp.Texto)
EjecucionMensaje=Comillas(Temp.Texto)+<T> Duplicado<T>

[Lista.Columnas]
Formula=244
Expresion=506
Orden=36

[Lista.NomXFormula.Formula]
Carpeta=Lista
Clave=NomXFormula.Formula
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFuente=Negro
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Localizar]
Nombre=Localizar
Boton=73
NombreEnBoton=S
NombreDesplegar=&Localizar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.LocalLocalizar]
Nombre=LocalLocalizar
Boton=0
UsaTeclaRapida=S
TeclaRapida=Alt+F3
NombreDesplegar=&Localizar
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar
Activo=S
Visible=S

[Acciones.LocalLocalizarSiguiente]
Nombre=LocalLocalizarSiguiente
Boton=0
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=Localizar &Siguiente
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Localizar Siguiente
Activo=S
Visible=S

[Detalle]
Estilo=Ficha
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=NomXFormula
Fuente={Tahoma, 9, Negro, []}
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

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Activo=S
Visible=S
EspacioPrevio=S

[Detalle.NomXFormula.Tipo]
Carpeta=Detalle
Clave=NomXFormula.Tipo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.NomXFormula.Comentarios]
Carpeta=Detalle
Clave=NomXFormula.Comentarios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.NomXFormula.Formula]
Carpeta=Detalle
Clave=NomXFormula.Formula
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=45
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=no NomXFormula:NomXFormula.FormulaCerrada

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 2 (Registros)
Activo=S
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
NombreEnBoton=S
AntesExpresiones=Forma(<T>NomXFormulaOrdenar<T>)

[Detalle.NomXFormula.Calculo]
Carpeta=Detalle
Clave=NomXFormula.Calculo
Editar=S
ValidaNombre=S
3D=S
Pegado=N
Tamano=14
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Expresion]
Nombre=Expresion
Boton=47
NombreEnBoton=S
NombreDesplegar=&Expresion
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=NomXFormulaExpresion
Antes=S
DespuesGuardar=S
Visible=S
ActivoCondicion=(NomXFormula:NomXFormula.Tipo=<T>Formula<T>) y (no NomXFormula:NomXFormula.FormulaCerrada)
AntesExpresiones=Asigna(Info.Formula, NomXFormula:NomXFormula.Formula)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Expresion
Expresion=Localizar
Localizar=Ordenar
Ordenar=Navegador
Navegador=(Fin)

[Lista.ListaAcciones]
(Inicio)=LocalLocalizar
LocalLocalizar=LocalLocalizarSiguiente
LocalLocalizarSiguiente=(Fin)

[Lista.ListaOrden]
(Inicio)=NomXFormula.Calculo<TAB>(Decendente)
NomXFormula.Calculo<TAB>(Decendente)=NomXFormula.Orden<TAB>(Acendente)
NomXFormula.Orden<TAB>(Acendente)=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=NomXFormula.Formula
NomXFormula.Formula=NomXFormula.Tipo
NomXFormula.Tipo=NomXFormula.Comentarios
NomXFormula.Comentarios=NomXFormula.Calculo
NomXFormula.Calculo=(Fin)
