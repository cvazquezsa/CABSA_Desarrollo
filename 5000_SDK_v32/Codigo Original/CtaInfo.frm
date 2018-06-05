[Forma]
Clave=CtaInfo
Nombre=<T>Información de la Cuenta<T>
Icono=6
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=730
PosicionInicialArriba=492
PosicionInicialAltura=209
PosicionInicialAncho=460
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaBloquearAjuste=N
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Cuenta,  CuentaNaturaleza(CtaInfo:Cta.EsAcreedora), CtaInfo:Cta.Tipo, Info.ContMoneda )
Menus=S
VentanaExclusiva=S
VentanaEscCerrar=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=182
ExpresionesAlMostrar=Asigna(Info.ContMoneda, Config.ContMoneda)
ExpresionesAlCerrar=Asigna(Info.PuedeDesglosar, Verdadero)
MenuPrincipal=(Lista)

[Ficha]
Estilo=Ficha
PestanaNombre=General
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CtaInfo
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroGeneral=Cta.Cuenta=<T>{Info.Cuenta}<T> AND CtaSaldo.Moneda=<T>{Info.ContMoneda}<T>

[Ficha.Cta.Descripcion]
Carpeta=Ficha
Clave=Cta.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Ficha.Cta.Categoria]
Carpeta=Ficha
Clave=Cta.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Cta.Familia]
Carpeta=Ficha
Clave=Cta.Familia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Cta.Grupo]
Carpeta=Ficha
Clave=Cta.Grupo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

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

[Ficha.SaldoContable]
Carpeta=Ficha
Clave=SaldoContable
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]
EspacioPrevio=N

[Notas.Cta.Notas]
Carpeta=Notas
Clave=Cta.Notas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62x4
ColorFondo=Plata

[Notas.Cta.Mensaje]
Carpeta=Notas
Clave=Cta.Mensaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata

[Acciones.Propiedades]
Nombre=Propiedades
Boton=35
NombreDesplegar=&Propiedades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PropInfo
Activo=S
Antes=S
Visible=S
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F11
EnMenu=S
ConCondicion=S
EjecucionCondicion=ConDatos(CtaInfo:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Cuenta, CtaInfo:Cta.Cuenta)<BR>Asigna(Info.Descripcion, CtaInfo:Cta.Descripcion)

[Acciones.Explorar]
Nombre=Explorar
Boton=66
NombreDesplegar=&Desglosar
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=VerAcum
Activo=S
Antes=S
Visible=S
Menu=&Explorar
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
EnMenu=S
AntesExpresiones=IrModulo(<T>CONT<T>)<BR>IrDireccion(<T>CONT<T>, Info.Cuenta)<BR>Asigna(Info.PuedeDesglosar, no CtaInfo:Cta.EsAcumulativa)

[Acciones.Salir]
Nombre=Salir
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Anexos]
Nombre=Anexos
Boton=77
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CtaInfo:Cta.Cuenta)
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Cuenta, CtaInfo:Cta.Cuenta)<BR>Asigna(Info.Descripcion, CtaInfo:Cta.Descripcion)
RefrescarDespues=S

[Acciones.Doc]
Nombre=Doc
Boton=17
Menu=&Ver
NombreDesplegar=&Documentación
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Expresion=VerDocumentacion(<T>CONT<T>, CtaInfo:Cta.Cuenta, <T>Documentación - <T>+CtaInfo:Cta.Descripcion)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(CtaInfo:Cta.Cuenta)
Visible=S

[Acciones.Presupuesto]
Nombre=Presupuesto
Boton=0
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Ctrl+F11
NombreDesplegar=&Presupuesto
EnMenu=S
TipoAccion=Formas
ClaveAccion=PresupuestoAcum
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Rama, <T>CONT<T>)<BR>Asigna(Info.Cuenta, CtaInfo:Cta.Cuenta)<BR>Asigna(Info.Descripcion, CtaInfo:Cta.Descripcion) <BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Acumulativa, CtaInfo:Cta.EsAcumulativa)<BR>Asigna(Info.VerAcum, CtaInfo:Cta.EsAcumulativa)<BR>Asigna(Info.SubCuenta, Nulo)<BR>Asigna(Info.Tipo, Nulo)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Propiedades
Propiedades=Anexos
Anexos=Doc
Doc=Presupuesto
Presupuesto=Explorar
Explorar=Salir
Salir=(Fin)

[Forma.MenuPrincipal]
(Inicio)=&Ver
&Ver=&Explorar
&Explorar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Cta.Descripcion
Cta.Descripcion=Cta.Categoria
Cta.Categoria=Cta.Familia
Cta.Familia=Cta.Grupo
Cta.Grupo=SaldoContable
SaldoContable=(Fin)
