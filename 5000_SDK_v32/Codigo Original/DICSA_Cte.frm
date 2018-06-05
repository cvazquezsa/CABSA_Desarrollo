[Forma]
Clave=DICSA_Cte
Nombre=Clientes
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=149
PosicionInicialArriba=155
PosicionInicialAlturaCliente=686
PosicionInicialAncho=982
AccionesTamanoBoton=19x5
Menus=S
BarraAcciones=S
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
PosicionSeccion1=54
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.FechaD, PrimerDiaAño(Hoy)) <BR>Asigna(Info.FechaA, Hoy)
MenuPrincipal=&Menú

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DICSA_Cte
Fuente={Tahoma, 11, Negro, []}
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
ConFuenteEspecial=S

[Ficha.Cliente]
Carpeta=Ficha
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Nombre]
Carpeta=Ficha
Clave=Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Agente]
Carpeta=Ficha
Clave=Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.Condicion]
Carpeta=Ficha
Clave=Condicion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.LimiteCredito]
Carpeta=Ficha
Clave=LimiteCredito
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.Direccion]
Carpeta=Ficha
Clave=Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.DireccionNumero]
Carpeta=Ficha
Clave=DireccionNumero
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Observaciones]
Carpeta=Ficha
Clave=Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Colonia]
Carpeta=Ficha
Clave=Colonia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Delegacion]
Carpeta=Ficha
Clave=Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CodigoPostal]
Carpeta=Ficha
Clave=CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Poblacion]
Carpeta=Ficha
Clave=Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Estado]
Carpeta=Ficha
Clave=Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Pais]
Carpeta=Ficha
Clave=Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Telefonos]
Carpeta=Ficha
Clave=Telefonos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RFC]
Carpeta=Ficha
Clave=RFC
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.FechaAlta]
Carpeta=Ficha
Clave=FechaAlta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.UltimoCobro]
Carpeta=Ficha
Clave=UltimoCobro
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.UltimaVenta]
Carpeta=Ficha
Clave=UltimaVenta
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.SaldoTotal]
Carpeta=Ficha
Clave=SaldoTotal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFuente=Negro
Tamano=20
ColorFondo=Blanco

[Ficha.SaldoVencido]
Carpeta=Ficha
Clave=SaldoVencido
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFuente=Negro
Tamano=20
ColorFondo=Blanco

[Ficha.ChequesDevueltos]
Carpeta=Ficha
Clave=ChequesDevueltos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=<T>F12 - Cerrar<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F12

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=DICSA_CteVentaAcum
ConFuenteEspecial=S
Fuente={Tahoma, 11, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Año<T>
IconosNombreNumerico=S
ElementosPorPagina=200
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=DICSA_CteVentaAcum:Ejercicio

[Lista.Ventas]
Carpeta=Lista
Clave=Ventas
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.Devoluciones]
Carpeta=Lista
Clave=Devoluciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.ChequesDevueltos]
Carpeta=Lista
Clave=ChequesDevueltos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=1

[Lista.DiasPromedioCobro]
Carpeta=Lista
Clave=DiasPromedioCobro
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Totalizador=0

[Lista.Columnas]
Ejercicio=38
Ventas=183
Devoluciones=177
ChequesDevueltos=179
DiasPromedioCobro=108
0=50
1=190

[Acciones.Saldos]
Nombre=Saldos
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F3
NombreDesplegar=<T>F3 - Saldos<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
Visible=S
ClaveAccion=DICSA_CteSaldo
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.Cobros]
Nombre=Cobros
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F4
NombreDesplegar=<T>F4 - Cobros<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
Visible=S
ClaveAccion=DICSA_CteCobro
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.ChequesPosfechados]
Nombre=ChequesPosfechados
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F5
NombreDesplegar=<T>F5 - Posfechados<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
Visible=S
ClaveAccion=DICSA_CteCobroPosfechado
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.Historico]
Nombre=Historico
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F6
NombreDesplegar=<T>F6 - Histórico<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
Visible=S
ClaveAccion=DICSA_CteHist
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.Referencias]
Nombre=Referencias
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F7
NombreDesplegar=<T>F7 - Referencias<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
Visible=S
ClaveAccion=DICSA_CteRef
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.Comentarios]
Nombre=Comentarios
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F8
NombreDesplegar=<T>F8 - Comentarios<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Formas
Visible=S
ClaveAccion=DICSA_CteComentarios
ActivoCondicion=ConDatos(Info.Cliente)

[Acciones.Cliente]
Nombre=Cliente
Boton=0
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F2
NombreDesplegar=<T>F2 - Cliente<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Controles Captura
Activo=S
Visible=S
ClaveAccion=Actualizar Vista
ConCondicion=S
EjecucionCondicion=Forma(<T>EspecificarCliente<T>)

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Ficha
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Lista
Lista=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cliente
Cliente=Saldos
Saldos=Cobros
Cobros=ChequesPosfechados
ChequesPosfechados=Historico
Historico=Referencias
Referencias=Comentarios
Comentarios=Cerrar
Cerrar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Cliente
Cliente=Nombre
Nombre=RFC
RFC=Direccion
Direccion=DireccionNumero
DireccionNumero=Colonia
Colonia=Observaciones
Observaciones=Delegacion
Delegacion=CodigoPostal
CodigoPostal=Poblacion
Poblacion=Estado
Estado=Pais
Pais=Telefonos
Telefonos=Agente
Agente=Condicion
Condicion=LimiteCredito
LimiteCredito=SaldoTotal
SaldoTotal=SaldoVencido
SaldoVencido=FechaAlta
FechaAlta=UltimoCobro
UltimoCobro=UltimaVenta
UltimaVenta=ChequesDevueltos
ChequesDevueltos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Ventas
Ventas=Devoluciones
Devoluciones=ChequesDevueltos
ChequesDevueltos=DiasPromedioCobro
DiasPromedioCobro=(Fin)

[Lista.ListaAcciones]
(Inicio)=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)
